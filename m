Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2547A67
	for <bridge@lists.linux.dev>; Mon, 12 Feb 2024 19:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765562; cv=none; b=EMs8lqkkP5hOjZcxE2RVkpllcr5pvQVBVdXwADC5156C4loKUqp51FXi6SLKhehQuEFW1GKixkrqMPJnLryfa8OqK8r828DoV7nG3h/T5q1Lx3aoKCz99+tMPbql/E0E1iuEb+eiTkAROYIoyLnUc/D0z7n+SjsB3jx1YmnFkiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765562; c=relaxed/simple;
	bh=z8oqdqEDhRCXk/yo/TAzsJzRFK9GPU2AFNlcqOKIRW8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i9BuEt1+RdaejJV2wTfLz4QylB7/9EjdLu2hWz7yctipsCW6fuhQ7/LdD4zN33NWDlkAIgZ7TCOHKW0kk4bQ1pdVWpXmRr6Q0UQ7LdwbRgb89aJn+yt7DVelOnp3pcwTF2Etuy5VLGLnB0OD5VUZUPeRON+j82cIrxzQ6L1LhlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=uixqRBd0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="uixqRBd0"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50eac018059so4539510e87.0
        for <bridge@lists.linux.dev>; Mon, 12 Feb 2024 11:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1707765557; x=1708370357; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owO5+EtRA7OjN0hrV4Td8NGEMC2elnvfBXu3RlDCwnE=;
        b=uixqRBd0UxNQiFrCWvuVCT4jFEmLqTUUC728eDkORBPD8yYekViKJeBHjAsmDMNyvI
         PZaS9VzziQmriPwm4Noc1B8fmc7lKNhJ7ahN1m0dSEBoMEIPew55SGG60pzvwOdNRp57
         3M0oGS0f0XKAiRjmpLZd+hKq58oofY77j+vd+fVvEeifQzyhfmGG1iEq+HDTo1hPUO/k
         vVBKdhdrPTDu9pXpVS+TxEky1f/fpmFCXx/9sEWbomh9Osf5V4E0jEVKsfs/pL/0h7rR
         +/l9HfyJr9CcSDo3RfcnfLdksZINlL9/5avVpTLr80QqqcSrFqps7byfwkGk/CPimFhi
         ex6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707765557; x=1708370357;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owO5+EtRA7OjN0hrV4Td8NGEMC2elnvfBXu3RlDCwnE=;
        b=c5pXGl7nnF5ToYWzCIxXbPBeYiz54RICgTcr9ap2LWeUzfP3f8cVAtzojXwXjNrglY
         HFvjgbwK8PosyVlnuspLpYmYBu+QDb/AZtlIzx4wPuTd9UAb5Fv+Jh4zSKodCalMTlfx
         hwci8zbWkGxHfLpvo0NCoLyhfmysnRHHIP5npTXF1oZkC7RAODc12r9IkXUtjoi1ibyW
         UY7U3t/WB6FSkJbf+jv7lhA7qZqKINF7kxC8KKuD2V8SAXFSbdItY9C9re0NR2b5zAKs
         SL+QG8zmHaciu0PYmdCTbJYMNbPlL/ftQfiuejZAh5JFRbTQis5VBbhZs5y1HF/+Hctq
         F81g==
X-Forwarded-Encrypted: i=1; AJvYcCUtXxnxvDTXwXZWZ6PcmsRWhxnxq7A9zbJoD4VUmkYgWfDAOGSRrxX4GA0+gs6e3WwWGkFGkRNC2SkTLJVqE5F8uwcJoDFb
X-Gm-Message-State: AOJu0YwwlphQiNGSloby2Plba4Cs6tCQYBnllyUofSfwmzA7QmElz4Oh
	M0MsN7UZAZY3A1mSERJpUKUIXPglW4XK9hG5PHnKQJ0i7T7R7AAueARWJJ8i78U=
X-Google-Smtp-Source: AGHT+IF/Lc0e5GGhvByl3h7ILfvksmYLQsBCRUOzv6y0e7AuRUvXvYkJTuUvcFB9zVgepzNpHxQKtg==
X-Received: by 2002:ac2:5990:0:b0:511:7681:1853 with SMTP id w16-20020ac25990000000b0051176811853mr5041194lfn.16.1707765557066;
        Mon, 12 Feb 2024 11:19:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXS0FWQv1bMUhtf7zrWpfkK1C9iLOEZbUPHxQn8ZQZzNk61uqLuB2OnvqiwR/XXkYOBMtJJyJJILVp2Hx7tlfNpLxLf/3oICdmAM25bX3xip6pfZ7PzxPfCK3Z5AzHN4/qa/Ymcc/7tp/04CmmAdiCBJ/S9d8fPA9agzLtEWzfrU78uS92cA6EJI63J3rZoZNpxgzLGn8myztIxzTYkfkJ+hGCkLlffPPuRFwzr0JZO1abPcfnTfQ1wnxTnc1z21Pnnn76Uko+m1fNu5iuitCMR
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id n9-20020ac24909000000b0051157349af3sm974647lfi.47.2024.02.12.11.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:19:16 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: olteanv@gmail.com,
	atenart@kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com
Subject: [PATCH v4 net 0/2] net: bridge: switchdev: Ensure MDB events are delivered exactly once
Date: Mon, 12 Feb 2024 20:18:42 +0100
Message-Id: <20240212191844.1055186-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

When a device is attached to a bridge, drivers will request a replay
of objects that were created before the device joined the bridge, that
are still of interest to the joining port. Typical examples include
FDB entries and MDB memberships on other ports ("foreign interfaces")
or on the bridge itself.

Conversely when a device is detached, the bridge will synthesize
deletion events for all those objects that are still live, but no
longer applicable to the device in question.

This series eliminates two races related to the synching and
unsynching phases of a bridge's MDB with a joining or leaving device,
that would cause notifications of such objects to be either delivered
twice (1/2), or not at all (2/2).

A similar race to the one solved by 1/2 still remains for the
FDB. This is much harder to solve, due to the lockless operation of
the FDB's rhashtable, and is therefore knowingly left out of this
series.

v1 -> v2:
- Squash the previously separate addition of
  switchdev_port_obj_act_is_deferred into first consumer.
- Use ether_addr_equal to compare MAC addresses.
- Document switchdev_port_obj_act_is_deferred (renamed from
  switchdev_port_obj_is_deferred in v1, to indicate that we also match
  on the action).
- Delay allocations of MDB objects until we know they're needed.
- Use non-RCU version of the hash list iterator, now that the MDB is
  not scanned while holding the RCU read lock.
- Add Fixes tag to commit message

v2 -> v3:
- Fix unlocking in error paths
- Access RCU protected port list via mlock_dereference, since MDB is
  guaranteed to remain constant for the duration of the scan.

v3 -> v4:
- Limit the search for exiting deferred events in 1/2 to only apply to
  additions, since the problem does not exist in the deletion case.
- Add 2/2, to plug a related race when unoffloading an indirectly
  associated device.

Tobias Waldekranz (2):
  net: bridge: switchdev: Skip MDB replays of deferred events on offload
  net: bridge: switchdev: Ensure deferred event delivery on unoffload

 include/net/switchdev.h   |  3 ++
 net/bridge/br_switchdev.c | 84 ++++++++++++++++++++++++++-------------
 net/switchdev/switchdev.c | 73 ++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 28 deletions(-)

-- 
2.34.1

