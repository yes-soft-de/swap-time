<?php


namespace App\Request;


use DateTime;

class ReportCreateRequest
{
    private $userID;

    private $swapItemID;

    private $date;

    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }

    /**
     * @return mixed
     */
    public function getSwapItemID()
    {
        return $this->swapItemID;
    }

    /**
     * @param mixed $swapItemID
     */
    public function setSwapItemID($swapItemID): void
    {
        $this->swapItemID = $swapItemID;
    }

    public function getDate():?\DateTime
    {
        try
        {
            return new DateTime((string)$this->date);
        }
        catch (\Exception $e)
        {
        }
    }

    public function setDate(\DateTime $date): self
    {
        try
        {
            $this->date = new \DateTime((string)$date);
        }
        catch (\Exception $e)
        {
        }

        return $this;
    }


}