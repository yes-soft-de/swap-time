<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\ReportEntity;
use App\Manager\ReportManager;
use App\Request\ReportCreateRequest;
use App\Response\ReportCreateResponse;
use App\Response\ReportResponse;

class ReportService
{
    private $autoMapping;
    private $reportManager;

    public function __construct(AutoMapping $autoMapping, ReportManager $reportManager)
    {
        $this->autoMapping = $autoMapping;
        $this->reportManager = $reportManager;
    }

    public function reportCreate(ReportCreateRequest $request)
    {
        $reportCreate = $this->reportManager->reportCreate($request);

        $response = $this->autoMapping->map(ReportEntity::class,ReportCreateResponse::class, $reportCreate);

        return $response;
    }

    public function getReports()
    {
        $itemsResponse = [];
        $items = $this->reportManager->getReports();

        foreach ($items as $item)
        {
            $itemsResponse[] = $this->autoMapping->map('array', ReportResponse::class, $item);
        }

        return $itemsResponse;
    }

    public function deleteReport($reportID)
    {
        return $this->reportManager->deleteReport($reportID);
    }
}