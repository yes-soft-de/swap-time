<?php


namespace App\Request;


use DateTime;

class SwapUpdateRequest
{
    private $id;

    private $date;

    private $userIdOne;

    private $userIdTwo;

    private $swapItemIdOne;

    private $swapItemIdTwo;

    private $cost;

    private $roomID;

    private $status;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setId($id): void
    {
        $this->id = $id;
    }

    /**
     * @return mixed
     */
    public function getDate()
    {
        try
        {
            return new DateTime((string)$this->date);
        }
        catch (\Exception $e)
        {
        }
    }

    /**
     * @param mixed $date
     */
    public function setDate($date): void
    {
        $this->date = $date;
    }

    /**
     * @return mixed
     */
    public function getUserIdOne()
    {
        return $this->userIdOne;
    }

    /**
     * @param mixed $userIdOne
     */
    public function setUserIdOne($userIdOne): void
    {
        $this->userIdOne = $userIdOne;
    }

    /**
     * @return mixed
     */
    public function getUserIdTwo()
    {
        return $this->userIdTwo;
    }

    /**
     * @param mixed $userIdTwo
     */
    public function setUserIdTwo($userIdTwo): void
    {
        $this->userIdTwo = $userIdTwo;
    }

    /**
     * @return mixed
     */
    public function getSwapItemIdOne()
    {
        return $this->swapItemIdOne;
    }

    /**
     * @param mixed $swapItemIdOne
     */
    public function setSwapItemIdOne($swapItemIdOne): void
    {
        $this->swapItemIdOne = $swapItemIdOne;
    }

    /**
     * @return mixed
     */
    public function getSwapItemIdTwo()
    {
        return $this->swapItemIdTwo;
    }

    /**
     * @param mixed $swapItemIdTwo
     */
    public function setSwapItemIdTwo($swapItemIdTwo): void
    {
        $this->swapItemIdTwo = $swapItemIdTwo;
    }

    /**
     * @return mixed
     */
    public function getCost()
    {
        return $this->cost;
    }

    /**
     * @param mixed $cost
     */
    public function setCost($cost): void
    {
        $this->cost = $cost;
    }

    /**
     * @return mixed
     */
    public function getRoomID()
    {
        return $this->roomID;
    }

    /**
     * @param mixed $roomID
     */
    public function setRoomID($roomID): void
    {
        $this->roomID = $roomID;
    }

    /**
     * @return mixed
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * @param mixed $status
     */
    public function setStatus($status): void
    {
        $this->status = $status;
    }


}