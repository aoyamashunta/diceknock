using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BossAttack6 : MonoBehaviour
{
    public GameObject Bomb = default;
    public GameObject Barrel = default;

    GameObject Instant_Bomb = default;

    Rigidbody Rigid_Bomb = default;

    public float _speedRange = 500f;
    [Range(350f, 450f)]public float _speedMin =  400f;
    [Range(550f, 600f)] public float _speedMax =  550f;

    public bool IsStart = false;

    public int BallNum = 0;
    public int BallMaxNum = 5;

    //乱数範囲
    Vector3 _vectorRange = default;
    [Range(-0.1f, -1f)]public float _vectorMin = -1f;
    [Range(0.1f, 1f)] public float _vectorMax =  1f;
    float deviation = 0.3f;

    void Start()
    {
        //0.3が中心位置、yは1以上上げない
        _vectorRange  = new Vector3(0 + deviation, 1, 0);
    }

    void Update()
    {
        if (IsStart)
        {
            Shot();
        } 
    }

    public void Shot(){

        if(BallNum < BallMaxNum){
            BallNum+= 1;

            _vectorRange = new Vector3(Random.Range(_vectorMin, _vectorMax+0.1f)+deviation, 1, 0);
            _speedRange = Random.Range(_speedMin, _speedMax+1);

            Instant_Bomb =  (GameObject)Instantiate(Bomb, Barrel.transform.position, Quaternion.identity);
            Rigid_Bomb = Instant_Bomb.GetComponent<Rigidbody>();
            Rigid_Bomb.AddForce((transform.forward + _vectorRange) * _speedRange);
        }
        else if(BallNum >= BallMaxNum)
        {
            IsStart = false;
            BallNum = 0;
        }
    }
}
