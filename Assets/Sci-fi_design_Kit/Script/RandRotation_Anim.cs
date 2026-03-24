using UnityEngine;

public class RandRotation_Anim : MonoBehaviour
{


    void Update()
    {

        transform.Rotate(Random.Range(100, 250) * Time.deltaTime, Random.Range(100, 250) * Time.deltaTime, Random.Range(100, 250) * Time.deltaTime);
    }
}