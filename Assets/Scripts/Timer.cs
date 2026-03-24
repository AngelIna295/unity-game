using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class Timer : MonoBehaviour
{
    public float startTimeMinutes = 20f;
    private float timeRemaining;
    public TextMeshProUGUI timerText; // Если вы используете TextMeshPro, замените на TextMeshProUGUI

    private bool timerRunning = true;

    void Start()
    {
        timeRemaining = startTimeMinutes * 60f;
    }

    void Update()
    {
        if (timerRunning)
        {
            if (timeRemaining > 0)
            {
                timeRemaining -= Time.deltaTime;
                UpdateTimerDisplay(timeRemaining);
            }
            else
            {
                timeRemaining = 0;
                timerRunning = false;
                UpdateTimerDisplay(0);
                Debug.Log("⏰ Время вышло!");
            }
        }
    }

    void UpdateTimerDisplay(float time)
    {
        int minutes = Mathf.FloorToInt(time / 60);
        int seconds = Mathf.FloorToInt(time % 60);
        timerText.text = string.Format("{0:00}:{1:00}", minutes, seconds);
    }
}
