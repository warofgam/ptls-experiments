from dltranz.seq_encoder.agg_feature_model import AggFeatureSeqEncoder
from dltranz.seq_encoder.rnn_encoder import RnnSeqEncoder
from dltranz.seq_encoder.transf_seq_encoder import TransfSeqEncoder


def create_encoder(params, is_reduce_sequence):
    encoder_type = params['encoder_type']
    if encoder_type == 'rnn':
        return RnnSeqEncoder(params, is_reduce_sequence)
    if encoder_type == 'transf':
        return TransfSeqEncoder(params, is_reduce_sequence)
    if encoder_type == 'agg_features':
        return AggFeatureSeqEncoder(params, is_reduce_sequence)

    raise AttributeError(f'Unknown encoder_type: "{encoder_type}"')
