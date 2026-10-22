Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660528;
	b=LH6MKlHkIyiS/CAuNzsz8YglJYST+rRYboVTAM3cOseuyht4kI++M2AKvH5OOsTXN5+R
	 1G+MjUjrXMM09RQcKHzUzdauM7STPdbDYtx29QlBL1aK/fKOIuysSAUlD3GlFTyJkiKkA
	 3m0X2Wd8dqejJLz6BT9n0Ah7+3m+xq1XDrBJb8SkmHHZfYIkJ9jXLnuqqEp03XCzcw6bR
	 XEPvRstQRoc6QaEjC8nVlE4XJU2cNtlkzx+O72zYdPTVqbwYNNz25YVdVfEn+26huhQxZ
	 8FvXIY+nBh3lvj1sGk1EFAfIJt6+x9v5HRBRRfx2ZX+RLw1MHBYd1bJBbyWpIFvnX/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gJVw9ABNp21KP8Dhio2Mev+A1bfhiVXJze+OMhpKRQE=;
	b=4iR8n8yjqPylgGJ8CEqJQ9PR1JmrtBCcqJz57flNFYZ5GOEyCLtGR9Kp8AmeVzB7Uokp
	 N/u9tomNLZrArvuwo5ap/XWiBLOxdvFUqXbnovp7URW/3yYmbG7NVSIYA/MTieG4ZdC9O
	 0L7dO2T7XI3unczuHs0gTXvLm5ruzJjXlGirqhwzDdT8IirvPMb+ols5HCl6rlcEh5wlB
	 BYs22ZsrmvCIzyNYA0ZflOMWjkzxMLNGNIJF+XLoQgAVtmtUOLGQQcYXZD9rnYRMM9nPp
	 h9OzgG1QMocs4YDXKoYredPmYMbfUOUSXDhGJti5wisJFS0yQ7QpWTrjYaDuYeSScbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jfCDv9QM;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E420606A31D
	for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 09:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E420606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jfCDv9QM
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-14394530ec6so2177896c88.1
        for <bridge@lists.linux.dev>; Thu, 22 Oct 2026 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660527; x=1793265327; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gJVw9ABNp21KP8Dhio2Mev+A1bfhiVXJze+OMhpKRQE=;
        b=jfCDv9QM0cz98bczKwlMRK6sJzKqAwMJ4e3wM19j/+wyWZs1Rd8N9BM+/CH1mWl+MN
         gHKwGC6b7QcWDPjdtK7Qe1qJY/pUJMzJPztYadQmFNDA+uE0XaXqaqMQwgLrge3y0rOO
         0gTrPA3CPtsHaqGMo3KgO2ZsIJTdAJr1b6tmn5kn+ghQtdhQHv4D2yqCbbRaIeOe05Ev
         WpXQeIAozKp6Sp1JGsBKTPOjD0IdUX1Lne5vJNkz/KfUZRyMTgi4F0VcKhguScasqBJ1
         4+yQBCA324U0JhOrgbyWfpkd2z1DGDA7kEwdzIvtP06tYCYPLLeFlJmQmr2sfvA8n4fH
         qVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660527; x=1793265327;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gJVw9ABNp21KP8Dhio2Mev+A1bfhiVXJze+OMhpKRQE=;
        b=KvmC3I2pZlHO3E8N2JHZkvmIX+E0QJCMccmHfZ9YjpeFmlEhM/ZPcVMXMawRwg5Fhk
         2h5xevjx9pyQTc3MLTKXuvmMDcTg29c4/XCEwzKFEGJjBguUuSGUr9FWmYLQEl+87ib+
         K0BFXoIpdpXCTK4kZL5IiGiC6LZdCkW+PXuJlAsPgUOrquTr+X8uC6QBJsSRYP8r7Wm9
         9IS4BNSd2ruT7Fi9ZS9OD78abgtwAxDRn5566VVCsLtX92scdbJCTCJ0/TZe1rMrhSB0
         mjtKSxeZBn3To2cKmS81GvWMO+KR2JwQoOZymbD5f4WqlybN5wA/0wYqAgv1FsKQ7AkB
         Rovg==
X-Forwarded-Encrypted: i=1; AKwUvBy59EOLL11VvB6BQiRILTII4/JghQPPLqJHceFhbhAbvUgXVLcUmQ4ujnMTaVMx78kyzlJXj5Y=@lists.linux.dev
X-Gm-Message-State: AFq9FYKyIL64BImUQQ3spZdsmqLCxbtamHPlX8hrchmQjIgtuTvvNOJU
	RGxDqE+gPDteEPEdf9rIzsUF7K86kyFayUMGqG3rAHlSIxtOT+vhnZAq
X-Gm-Gg: AYBFou353RWiaETLTonWDetETe8nevNV/KnCAQmcHdzjBQKcdtRYvxi/SCU/lFD4CsD
	+4YihLoj4g72klSAtZGKwHK/Eh4QeZISio1xbJbdDJVjOo5yamBnBJbp+kW8OGA5y0xqZUj29QY
	QC0d85UfZKU5A5eyxmF9gwKCe+CFt55ciS0yZm/wBYU+ThwzEODUkQTvnWpXh3OBs6dlX5eKLCT
	QnwwPad7MMsvihC8Wjs0nYw65ot0xdsJM/lfhD5qaKXcbm7GXyxhVtWD2+SF5DUQEkqck/+72CM
	b+467T/jM7t/ssnbp2WgaPu7Rmvzx2qvpWBvJh4NewIOmTmfEWC1nqsqh2QpObz8Z4lkKOsa436
	Rw+/PiqhCmEoqSAxkVmj4UyH2m19Q3DpWGDHqR/1OFZXqxZpOnwfj07+T5es1LhhilQ9IjyjrUD
	FhyXr/Rur9dqNABwq4A17y/n3LojHrIS7EoPRK98UUyNw7idWa4sVnu/U/+k1sxZ+FcYUqTyuGa
	qJDf4oh/X4Of00gO06e8I3INnTCFwcFRdtsNgJVG81/qBRz50T40T8D3HmraCuSq3kR7o4qkpKH
	6I8Dgoh5FebjQN08oKk=
X-Received: by 2002:a05:701b:4189:20b0:144:fa58:95d8 with SMTP id a92af1059eb24-190a599a3b9mr6064440c88.27.1792660527292;
        Thu, 22 Oct 2026 02:15:27 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm19853944c88.5.2026.10.22.02.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:15:26 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] net: bridge: MRP state is not propagated to MSTI zero
Date: Thu, 22 Oct 2026 02:15:20 -0700
Message-Id: <20261022091520.3651032-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

With MST enabled, the bridge data path uses MSTI-0 per-VLAN state.
br_set_state() normally synchronizes MSTI 0 through br_mst_set_state(),
but br_mrp_set_port_state() changes only p->state and sends a switchdev
notification.

The MRP-aware guard prevents other STP transitions from synchronizing
MSTI 0.  Direct bridge MST commands cannot address MSTI 0, and direct
VLAN-state changes are rejected while MST is enabled.  A ring port
marked BLOCKING by MRP therefore keeps its PVID/MSTI-0 state at
FORWARDING and continues to pass data.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1:

  net_bridge_port.state: BLOCKING
  port VLAN state:       forwarding

  MST disabled control:  egress=0 ingress=0
  MST enabled candidate: egress=1 ingress=1

The MRP instance add and PORT_STATE BLOCKED requests both returned
success.  The port was observably blocked in sysfs but still forwarded
real broadcast Ethernet frames.

The MRP port-state path needs to synchronize MSTI 0, for example by
calling br_mst_set_state(p, 0, port_state, NULL), in addition to
updating p->state.

This is distinct from candidate BR-039 (MST with VLAN filtering disabled)
and from BR-005 (deletion-time MRP forwarding).  I found no matching
upstream fix or CVE.

The test used a diagnostic switchdev endpoint only to acknowledge the
MRP object.  It did not change bridge port state, VLAN state or packet
forwarding.

The PoC, module source and full logs are available on request.

This was found with a multi-agent workflow; the
state/forwarding differential was reproduced in QEMU.

Thanks,
Cheng Yongkang
