using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class EnemyController : MonoBehaviour
{
    public Transform player;
    public List<Transform> patrolPoints;
    public float viewAngle = 120f;
    public float detectionRadius = 15f;
    public float waitTimeAtPoint = 10f;
    public float lostSightDuration = 5f;
    public float catchDistance = 1.5f;
    public LayerMask obstacleMask;

    public float stuckDuration = 20f;              // ⬅️ Время, через которое считается "застрял"
    public float movementThreshold = 0.05f;        // ⬅️ Насколько нужно двигаться, чтобы считалось "движением"

    private NavMeshAgent agent;
    private int currentPatrolIndex = 0;
    private bool isChasing = false;

    private float lostSightTimer = 0f;
    private float waitTimer = 0f;
    private bool isWaiting = false;
    private bool hasCaughtPlayer = false;

    private float stuckTimer = 0f;
    private Vector3 lastPosition;

    public Animator monster;

    void Start()
    {
        monster.SetBool("IsWalk", true);
        agent = GetComponent<NavMeshAgent>();
        GoToNextPatrolPoint();
        lastPosition = transform.position;
    }

    void Update()
    {
        if (CanSeePlayer())
        {
            isChasing = true;
            isWaiting = false;
            lostSightTimer = 0f;
            agent.SetDestination(player.position);
        }
        else if (isChasing)
        {
            lostSightTimer += Time.deltaTime;

            if (lostSightTimer >= lostSightDuration || agent.velocity.magnitude < 0.1f)
            {
                isChasing = false;
                lostSightTimer = 0f;
                StartWaiting();
            }
            else
            {
                agent.SetDestination(player.position);
            }
        }
        else
        {
            if (isWaiting)
            {
                waitTimer += Time.deltaTime;
                if (waitTimer >= waitTimeAtPoint)
                {
                    isWaiting = false;
                    GoToNextPatrolPoint();
                }
            }
            else
            {
                // ⬇️ Проверка на застревание
                float movement = Vector3.Distance(transform.position, lastPosition);
                if (movement < movementThreshold)
                {
                    stuckTimer += Time.deltaTime;
                    if (stuckTimer >= stuckDuration)
                    {
                        Debug.Log("Монстр застрял, меняю точку.");
                        stuckTimer = 0f;
                        GoToNextPatrolPoint();
                        return;
                    }
                }
                else
                {
                    stuckTimer = 0f;
                }

                if (!agent.pathPending && agent.remainingDistance < 0.5f)
                {
                    StartWaiting();
                }

                lastPosition = transform.position;
            }
        }

        // ⬇️ Проверка на ловлю
        if (!hasCaughtPlayer && Vector3.Distance(transform.position, player.position) <= catchDistance)
        {
            CatchPlayer();
        }
    }

    void GoToNextPatrolPoint()
    {
        monster.SetBool("IsWalk", true);
        if (patrolPoints.Count == 0) return;

        int nextIndex = currentPatrolIndex;

        while (patrolPoints.Count > 1 && nextIndex == currentPatrolIndex)
        {
            nextIndex = Random.Range(0, patrolPoints.Count);
        }

        currentPatrolIndex = nextIndex;
        agent.SetDestination(patrolPoints[currentPatrolIndex].position);
    }


    void StartWaiting()
    {
        monster.SetBool("IsWalk", false);
        isWaiting = true;
        waitTimer = 0f;
        agent.ResetPath();
    }

    bool CanSeePlayer()
    {
        Vector3 dirToPlayer = (player.position - transform.position).normalized;
        float distanceToPlayer = Vector3.Distance(transform.position, player.position);

        if (distanceToPlayer <= detectionRadius)
        {
            if (Vector3.Angle(transform.forward, dirToPlayer) < viewAngle / 2f)
            {
                if (!Physics.Raycast(transform.position + Vector3.up, dirToPlayer, distanceToPlayer, obstacleMask))
                {
                    return true;
                }
            }
        }

        return false;
    }

    void CatchPlayer()
    {
        hasCaughtPlayer = true;

        if (player.TryGetComponent<CharacterController>(out var controller))
            controller.enabled = false;

        monster.SetBool("IsWalk", false);
        agent.isStopped = true;

#if UNITY_EDITOR
        UnityEditor.EditorApplication.isPlaying = false;
#else
        UnityEngine.SceneManagement.SceneManager.LoadScene("GameOver");
#endif
    }
}
