using UnityEngine;

public class RandRotation_Anim_invert : MonoBehaviour
{


    void Update()
    {

        transform.Rotate(Random.Range(-100, -400) * Time.deltaTime, Random.Range(-100, -400) * Time.deltaTime, Random.Range(-100, -400) * Time.deltaTime);
    }
}