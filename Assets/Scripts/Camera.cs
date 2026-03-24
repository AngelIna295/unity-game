using UnityEngine;


public class Camera : MonoBehaviour
{
    public float mouseSensitivity = 100f;
    public Transform playerBody;
    float xRotation;
    float yRotation;


    void Start()
    {
        Cursor.lockState = CursorLockMode.Locked;
        QualitySettings.vSyncCount = 1;
    }

    void Update()
    {

        // float mouseX = Input.GetAxis("Mouse X") * mouseSensitivity * Time.deltaTime;
        //   float mouseY = Input.GetAxis("Mouse Y") * mouseSensitivity * Time.deltaTime;

        // xRotation -= mouseY;

        //xRotation = Mathf.Clamp(xRotation, -80, 80);

        // playerBody.localRotation = Quaternion.Euler(xRotation, 0, 0);

        // transform.Rotate(Vector3.up * mouseX);





        float mouseX = Input.GetAxisRaw("Mouse X") * mouseSensitivity * Time.deltaTime;
        float mouseY = Input.GetAxisRaw("Mouse Y") * mouseSensitivity * Time.deltaTime;

        yRotation += mouseX;
        xRotation -= mouseY;
        xRotation = Mathf.Clamp(xRotation, -90f, 90f);

        transform.rotation = Quaternion.Euler(xRotation, yRotation, 0);
        playerBody.rotation = Quaternion.Euler(0, yRotation, 0);
    }


}
