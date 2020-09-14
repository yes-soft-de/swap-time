<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\ReportCreateRequest;
use App\Service\ReportService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class ReportController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $reportService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, ReportService $reportService)
    {
        parent::__construct($serializer);

        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->reportService = $reportService;
    }

    /**
     * @Route("/report", name="reportCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function reportCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,ReportCreateRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->reportService->reportCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/report", name="getreports", methods={"GET"})
     * @return JsonResponse
     */
    public function getReports()
    {
        $response = $this->reportService->getReports();

        return $this->response($response,self::FETCH);
    }
}
