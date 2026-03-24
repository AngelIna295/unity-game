using UnityEngine;

public class Btn_Exit : MonoBehaviour
{
    public GameObject UI_PC;
    public CharacterController freezeMove;
    public Camera freezeCamera;

    void Start()
    {

    }
    public void Exit()
    {
        PC.isActive = false;
        freezeCamera.enabled = true;
        freezeMove.enabled = true;
        Cursor.visible = false;
        Cursor.lockState = CursorLockMode.Locked;
        UI_PC.SetActive(false);
    }
}
