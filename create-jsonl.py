import os
import json

TRAINING_DATA_DIRNAME = "training-data"
PROMPT_FILENAME = "prompt.txt"
COMPLETION_FILENAME = "completion.star"

# Using tips from https://platform.openai.com/docs/guides/fine-tuning/preparing-your-dataset
PROMPT_SEPARATOR = "\n\n###\n\n"
COMPLETION_STOP_SEQUENCE = "\n### END"

PROMPT_PREFIX = "A Kurtosis Starlark script to "

with open("output.jsonl", 'w') as output_fp:
    for pair_dirname in os.listdir(TRAINING_DATA_DIRNAME):
        prompt_filepath = os.path.join(TRAINING_DATA_DIRNAME, pair_dirname, PROMPT_FILENAME)
        with open(prompt_filepath) as prompt_fp:
            prompt_contents = prompt_fp.read()
            if PROMPT_SEPARATOR in prompt_contents:
                raise("Prompt '" + prompt_filepath + "' contains prompt separator")

        completion_filepath = os.path.join(TRAINING_DATA_DIRNAME, pair_dirname, COMPLETION_FILENAME)
        with open(completion_filepath) as completion_fp:
            completion_contents = completion_fp.read()
            if COMPLETION_STOP_SEQUENCE in completion_contents:
                raise("Prompt '" + completion_filepath + "' contains completion stop sequence")

        output_obj = {
            "prompt": PROMPT_PREFIX + prompt_contents + PROMPT_SEPARATOR,
            # To comply with the suggestion that each completion start with a whitespace per https://platform.openai.com/docs/guides/fine-tuning/data-formatting
            "completion": "\n" + completion_contents + COMPLETION_STOP_SEQUENCE,
        }

        output_fp.write(json.dumps(output_obj) + "\n")
