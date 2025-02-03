FROM public.ecr.aws/lambda/nodejs:22

# Copy function code
COPY hello.js ${LAMBDA_TASK_ROOT}
  
# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "hello.handler" ]
