using UnityEngine;

public class RotateAnimation : MonoBehaviour
{

    public int velocityX = 0;
    public int velocityY = 0;
    public int velocityZ = 0;
    void Update()
    {

        transform.Rotate(velocityX * Time.deltaTime, velocityY * Time.deltaTime, velocityZ * Time.deltaTime);

    }
}