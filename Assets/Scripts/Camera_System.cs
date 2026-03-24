using UnityEngine;
using UnityEngine.Video; // Обязательно

public class Camera_System : MonoBehaviour, IInteractable
{
    public GameObject UI_screen;
    public bool isActive = false;
    public CharacterController freezeMove;
    public Camera freezeCamera;

    private Vector3 originalPosition;
    public bool isCurrentlyGlitching = false;

    public VideoPlayer glitchVideoPlayer; // ← Добавь это поле и привяжи в инспекторе

    void Start()
    {
        UI_screen.SetActive(false);
        originalPosition = transform.localPosition;
    }

    public void Interact()
    {
        if (isCurrentlyGlitching)
            return;

        freezeCamera.enabled = false;
        freezeMove.enabled = false;
        Cursor.visible = true;
        Cursor.lockState = CursorLockMode.None;
        isActive = true;
        UI_screen.SetActive(true);
    }

    public void Exit()
    {
        freezeCamera.enabled = true;
        freezeMove.enabled = true;
        Cursor.visible = false;
        Cursor.lockState = CursorLockMode.Locked;
        isActive = false;
        UI_screen.SetActive(false);
    }

    // 🔥 ВОТ ЭТОТ МЕТОД ОБЯЗАТЕЛЕН
    public void TriggerGlitch()
    {
        isCurrentlyGlitching = true;

        // Включить видео
        if (glitchVideoPlayer != null)
        {
            glitchVideoPlayer.Play();
        }

        // Скрыть UI
        if (UI_screen.activeSelf)
        {
            Exit();
        }

        UI_screen.SetActive(false);
    }
}
