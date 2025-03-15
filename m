Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60619CC06
	for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068923; cv=none; b=sS3D/zC9I+lZGCtfDaQukC3uxJ58PC1UdsPAixdsxz/nvVM2nPp8cA6oAXLNqLDxJkhyMWA0hOOiIiu99mjawcZV1MOHNJBVyCb34hffPGST58WFsEHqwDxz2dB3tnBsP+XQ2mxONpoM5+uCMVU4QAEMrzYoa9dKOykNMJFAIV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068923; c=relaxed/simple;
	bh=Z23rRndO03NcWjeUO2Bb+pclUVmTWvGLV3Gq+hK4HsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNLoIWvyESgtQtAWWiAL6hJr9GPjuo0Ux5RBZ173wKvId9AWDl+fNlWTiil7Cah0VYWTAdxD8tBvGepfgeOavKkXtyCIClWDQP0nEQoJPmrccK9kkFE3nO21+mrhtG5CL/LSsnJON6ut7YJwN/EWAm0bnDzXP9lfIKjPWORzJFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuOtagQz; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuOtagQz"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso588014766b.1
        for <bridge@lists.linux.dev>; Sat, 15 Mar 2025 13:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742068920; x=1742673720; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OWCNG8MCvnV9bUc6X1qyMGw14Enxyxd+fZVYaRBs7C0=;
        b=RuOtagQzMogbRTFK8QhUJ7I2BLSigXcUnl6Tf4yvKFO8eE0w+lnBq3mDgJaOCqedkB
         ISuV8bkiWM+FMV/bz9S1zILTWL7TZH+fOtXfP+Ks//D6YKn45ayzUz4v8jTdsJ5t+N2L
         mdvb5SmATvLaDL9Ezt15/ckHy4KPgx4UcHGsGVA7ClU+fePyYnJtWRhClDAleq/w2A8N
         InyhAsthtI87KTF0XuPxvIvZBLwVXH29iFOyI7qCG486O9JcWezjQ+N76QeflO/9Bwu9
         xLPicQMi4w0jF05uz51Cbl6pmDPj+JdJBLzcThQWeCRDr6JbYR1f0h13vdqeGckK3+Xp
         3fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742068920; x=1742673720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWCNG8MCvnV9bUc6X1qyMGw14Enxyxd+fZVYaRBs7C0=;
        b=soemMQccJXIfNSh5P4V8i8UDCugQttQPyEdX0t/LdiIVvZlfE7Z4vNn3mnduk/04f+
         345AFrrdN9mc7UWUuJB9HHZK/PdlJT5u7MkEQPxl3v/HbJWsTGY4TuCkW8oMRcXlovxB
         2+QFYC+nUfXNV9saL62Az71+0u0aButjNWJMkmZgD0Q0somAEFSxiLEiAUt7x70jny2T
         zI9vLtL2uBRzxNZavCywo+brpXgebwyUgI/YaR5XE7Fu0z1tdJFm6AyMa7QnZOxNk0CN
         BHvKecoqtGPgyHjIYi/46blxbzVSxUIDqTewKqb9/j1QvUVMpV9N12a9iZjJxgjPYPXA
         qHUw==
X-Forwarded-Encrypted: i=1; AJvYcCXiRyEz5ikOhmpyVxodxExfj0hADE/OV3SiQe3wsQO+fuI+8nvCEblfDs9ZpKGF3ea0WJ/xzkM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1uDa0RccVOjS8OjI9dpqorZ/g/Hoih4VlRsYMCb5T+1pOUizP
	lBAfitlmoT7M87bPpZW1Cj8OmBHRCLMAg7L86zgSZiZBNtRHuzUv
X-Gm-Gg: ASbGncuA95VvP6t3AB2IULxTMidBRRqLop+v6HIUDZ9POrtTA5/BYpzoPUJkNyDKLrd
	Lh/Ds+NO18lty7WU6MgWcDhKaHg50Vn5Cm6IR9lXVRj8oSEsON9kep3zhvB2xwHsslYZ9fIttqD
	SCBESy012Xe/Wqp0ll6c5l0CY0+dB7AEvJiRnPbxY4q/+U/Gytyl5RZ4seA1nO7L1YlWZ1RHTP/
	uk7s0ARtvalXvVa9+E2VoJuc5Y+Dsw1aDt6ckX6hDSi0eEd1rXc6wbKgmkNQxd8G18hv3vtp6JU
	oAkJ3f6D9z+Hf7d3WdgAqHpbI7OFGRu1BFVD5EPc5sx5q5F2i5wVRn18WNSrvYHnzBddttpwlnn
	T1eGjI1I13fFusyjaVuOcjGWIAiqddkqbCLqr6HuvnYebrhx3dV5BRNOkH/rHAJJsw7Z18vEb9A
	==
X-Google-Smtp-Source: AGHT+IF8gayXt91PRDutGk4V82DqfdZfU+ap3enKi/TuuDYAbCXOzpfh+hBjypvjScaqAOLFckwunQ==
X-Received: by 2002:a17:907:928c:b0:ac2:9a71:25ab with SMTP id a640c23a62f3a-ac33025412amr958629566b.16.1742068920017;
        Sat, 15 Mar 2025 13:02:00 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a489c9sm411456766b.152.2025.03.15.13.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:01:59 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v10 nf-next 0/3] netfilter: fastpath fixes
Date: Sat, 15 Mar 2025 21:01:44 +0100
Message-ID: <20250315200147.18016-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several fixes for the existing software forward-fastpath code, also
needed for the software bridge-fastpath.

DEV_PATH_BR_VLAN_UNTAG_HW should not be applied to dsa user-ports and
not to dsa foreign ports. Furthermore DEV_PATH_MTK_WDMA needs to be
introduced to nft_dev_path_info().

Split from patch-set: bridge-fastpath and related improvements v9

Eric Woudstra (3):
  netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to
    nft_dev_path_info()
  netfilter: nft_flow_offload: No ingress_vlan forward info for dsa user
    port
  bridge: No DEV_PATH_BR_VLAN_UNTAG_HW for dsa foreign

 include/net/switchdev.h          |  1 +
 net/bridge/br_private.h          | 10 ++++++++++
 net/bridge/br_switchdev.c        | 15 +++++++++++++++
 net/bridge/br_vlan.c             |  7 ++++++-
 net/netfilter/nft_flow_offload.c | 10 ++++++++++
 net/switchdev/switchdev.c        |  2 +-
 6 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.47.1

