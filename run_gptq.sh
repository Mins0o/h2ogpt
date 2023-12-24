EXLLAMA_MODEL_NAME="TheBloke/WizardLM-1.0-Uncensored-Llama2-13B-GPTQ"
PROMPT_TYPE="vicuna11"
LOADING_GPTQ="gptq_model-4bit-128g"
GPTQ_REVISION="gptq-4bit-128g-actorder_True"
IS_LOAD_EXLLAMA=1


H2OGPT_ENABLE_HEAP_ANALYTICS=False HF_DATASETS_OFFLINE=1 TRANSFORMERS_OFFLINE=1 
python generate.py \
--enable_heap_analytics=False \
--gradio_offline_level=2 \
--base_model=$EXLLAMA_MODEL_NAME \
--prompt_type=$PROMPT_TYPE \
--load_gptq=$LOADING_GPTQ \
--revision=$GPTQ_REVISION \
--load_exllama=$IS_LOAD_EXLLAMA \
--use_safetensors=True \
--save_dir='/workspace/save/' \
--temperature=0.4 \
--do_sample=True \
--repetition_penalty=1.17 \
--langchain_mode=MyData \
--user_path="user_data" \
--chat=True \
--show_copy_button=True \
--hf_embedding_model="sentence-transformers/all-MiniLM-L6-v2" \
--use_llm_if_no_docs=True \
--visible_h2ogpt_logo=True \
--visible_login_tab=False \
--visible_models_tab=False \
--visible_langchain_agents='[]' \
--height=450 \
--auth='/workspace/h2ogpt_auth/auth.json' \
--auth_message='!!DO NOT USE REALWORLD PSWD!! 
The login is for persisting session. 
Freely make a new id/pswd pair. 
PSWD WILL BE SAVED IN PLAIN TEXT' \
&


# run_docker.sh
# sudo docker run \
# -p 8081:7860 \
# --rm -it \
#      -v ./_h2ogpt_env/.cache/:/workspace/.cache \
#        -v ./_h2ogpt_env/save/:/workspace/save \
#   -v ./_h2ogpt_env/user_data/:/workspace/user_data \
#  -v ./_h2ogpt_env/user_paste/:/workspace/user_paste \
#       -v ./_h2ogpt_env/users/:/workspace/users \
#   -v ./_h2ogpt_env/db_nonusers/:/workspace/db_nonusers \
#   -v ./_h2ogpt_env/db_dir_UserData/:/workspace/db_dir_UserData \
#    -v ./model_collection/hub/:/workspace/.cache/huggingface/hub \
#  -v ./model_collection/torch/:/workspace/.cache/torch \
#        -v ./model_collection/:/workspace/model_collection \
# --gpus=all --ulimit memlock=-1:-1 --shm-size=4g \
# --entrypoint=/bin/bash \
# h2ogpt
