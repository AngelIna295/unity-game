using UnityEngine;

public class TriggerInput : MonoBehaviour
{
    public Btn_door doorScript;   // Дверь 1
    public Btn_door2 doorScript2; // Дверь 2

    private bool playerInside = false;

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            playerInside = true;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            playerInside = false;
        }
    }

    private void Update()
    {
        if (playerInside)
        {
            if (Input.GetKeyDown(KeyCode.Z))
            {
                doorScript.OpenCLose(); // Только дверь 1
            }
            if (Input.GetKeyDown(KeyCode.X))
            {
                doorScript2.OpenCLose(); // Только дверь 2
            }
        }
    }
}
