using UnityEngine;

public class NewBehaviourScript : MonoBehaviour
{
    [SerializeField] private CharacterController _characterController;
    [SerializeField] private Transform _cameraTransform;
    [SerializeField] private Transform _checkGround;
    [SerializeField] private LayerMask _groundMask;

    [Header("Settings")]
    [SerializeField] private float _checkRadiusSphere = 0.2f;
    [SerializeField] private float _gravity = -14f;
    [SerializeField] private float _speed = 4f;
    [SerializeField] private float _speedrun = 7f;
    [SerializeField] private float _jumpHeight = 1f;

    [Range(1, 100)]
    [SerializeField] private float _sensivity = 5000f;

    float rotationX;
    bool isGrounded;

    Vector3 velocity;
    Vector3 move;
    void Start()
    {
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
    }

    void Update()
    {
        Velocity();
        Rotate();
        Move();
    }

    private void Rotate()
    {
        float mouseX = Input.GetAxis("Mouse X") * _sensivity * Time.deltaTime;
        float mouseY = Input.GetAxis("Mouse Y") * _sensivity * Time.deltaTime;

        rotationX -= mouseY;

        rotationX = Mathf.Clamp(rotationX, -80, 80);

        _cameraTransform.localRotation = Quaternion.Euler(rotationX, 0, 0);

        transform.Rotate(Vector3.up * mouseX);
    }

    private void Move()
    {
        float moveX = Input.GetAxis("Horizontal");
        float moveY = Input.GetAxis("Vertical");

        move = transform.forward * moveY + transform.right * moveX;

        if (Input.GetKey(KeyCode.LeftShift) && (moveX != 0 || moveY != 0))
        {
            _characterController.Move(move * _speedrun * Time.deltaTime);
        }
        else
        {
            _characterController.Move(move * _speed * Time.deltaTime);
        }
    }

    private void Velocity()
    {
        isGrounded = Physics.CheckSphere(_checkGround.position, _checkRadiusSphere, _groundMask);
        if (isGrounded && velocity.y < 0)
        {
            velocity.y = -2f;
        }

        velocity.y += Time.deltaTime * _gravity;

        if (Input.GetButtonDown("Jump") && isGrounded)
        {
            velocity.y = Mathf.Sqrt(_jumpHeight * -2f * _gravity);
        }

        _characterController.Move(velocity * Time.deltaTime);
    }
}
