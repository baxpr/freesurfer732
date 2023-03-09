# Initial update and utils
FROM centos:7
RUN yum -y update && \
    yum -y install wget tar zip unzip && \
    yum -y install bc libgomp perl tcsh vim-common mesa-libGL && \
    yum -y install libXext libSM libXrender libXmu && \
    yum -y install mesa-libGLU mesa-dri-drivers && \
    yum -y install ImageMagick && \
    yum -y install xorg-x11-server-Xvfb xorg-x11-xauth which && \
    yum -y install java-1.8.0-openjdk && \
    yum clean all

# Freesurfer
# https://surfer.nmr.mgh.harvard.edu/fswiki/rel7downloads
# https://surfer.nmr.mgh.harvard.edu/fswiki//FS7_linux
ENV FSVER=7.2.0
RUN cd /usr/local && \
    wget https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/${FSVER}/freesurfer-linux-centos7_x86_64-${FSVER}.tar.gz && \
    tar -zxpf freesurfer-linux-centos7_x86_64-${FSVER}.tar.gz && \
    rm freesurfer-linux-centos7_x86_64-${FSVER}.tar.gz
ENV FREESURFER_HOME /usr/local/freesurfer
RUN ${FREESURFER_HOME}/bin/fs_install_mcr R2014b

# setup fs env
ENV OS Linux
ENV FREESURFER_HOME /usr/local/freesurfer
ENV FREESURFER /usr/local/freesurfer
ENV SUBJECTS_DIR /usr/local/freesurfer/subjects
ENV LOCAL_DIR /usr/local/freesurfer/local
ENV FSFAST_HOME /usr/local/freesurfer/fsfast
ENV FMRI_ANALYSIS_DIR /usr/local/freesurfer/fsfast
ENV FUNCTIONALS_DIR /usr/local/freesurfer/sessions

# set default fs options
ENV FS_OVERRIDE 0
ENV FIX_VERTEX_AREA ""
ENV FSF_OUTPUT_FORMAT nii.gz

# Quiet warnings
ENV XDG_RUNTIME_DIR /tmp

# mni env requirements
ENV MINC_BIN_DIR /usr/local/freesurfer/mni/bin
ENV MINC_LIB_DIR /usr/local/freesurfer/mni/lib
ENV MNI_DIR /usr/local/freesurfer/mni
ENV MNI_DATAPATH /usr/local/freesurfer/mni/data
ENV MNI_PERL5LIB /usr/local/freesurfer/mni/share/perl5
ENV PERL5LIB /usr/local/freesurfer/mni/share/perl5

# Path
ENV PATHFS1 /usr/local/freesurfer/bin:/usr/local/freesurfer/fsfast/bin
ENV PATHFS2 /usr/local/freesurfer/tktools:/usr/local/freesurfer/mni/bin
ENV PATHSYS /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PATH ${PATHFS1}:${PATHFS2}:${PATHSYS}

# Entrypoint
ENTRYPOINT ["bash"]
