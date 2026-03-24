using UnityEngine;

public class Btn_CameraExit : MonoBehaviour
{
    public GameObject UI_screen;
    public CharacterController freezeMove;
    public Camera freezeCamera;

    void Start()
    {
        UI_screen.SetActive(false);
    }
    public void Exit()
    {
        freezeCamera.enabled = true;
        freezeMove.enabled = true;
        Cursor.visible = false;
        Cursor.lockState = CursorLockMode.Locked;
        UI_screen.SetActive(false);
    }
}
