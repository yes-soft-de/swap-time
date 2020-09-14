<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\ReportEntity;
use App\Repository\ReportEntityRepository;
use App\Request\ReportCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class ReportManager
{
    private $autoMapping;
    private $entityManager;
    private $reportEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ReportEntityRepository $reportEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->reportEntityRepository = $reportEntityRepository;
    }

    public function reportCreate(ReportCreateRequest $request)
    {
        $reportCreate = $this->autoMapping->map(ReportCreateRequest::class, ReportEntity::class, $request);

        $reportCreate->setDate($request->getDate());

        $this->entityManager->persist($reportCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $reportCreate;
    }

    public function getReports()
    {
        return $this->reportEntityRepository->getReports();
    }

}