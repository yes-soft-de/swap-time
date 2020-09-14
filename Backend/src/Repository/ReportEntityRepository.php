<?php

namespace App\Repository;

use App\Entity\ReportEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method ReportEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ReportEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ReportEntity[]    findAll()
 * @method ReportEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ReportEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ReportEntity::class);
    }

    public function getReports()
    {
        return $this->createQueryBuilder('report')

            ->select('report.id', 'report.userID', 'report.swapItemID', 'report.date')

            ->orderBy('report.id', 'ASC')

            ->getQuery()
            ->getResult();
    }
}
