Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39413EFFA
	for <bridge@lists.linux.dev>; Wed, 14 Feb 2024 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946814; cv=none; b=t1dXw85vfk3xYrk1ujq9Xl43cOWzVL1Jqd17ZjflHsXR9SO64s+qpB+VBwezIBbysTNV8Fg+5WVFEFMs8+jkBdSveVjXJ5DtY1/fS99R74HMHHSj9WgIUEqYIsnJMiNYRTU/rxLiwpLQNdA3Jp4bqwWqAuUCExHzB2Ep+qWvvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946814; c=relaxed/simple;
	bh=zAM5FyBfdOj0AR3MA2fx8mTDfs9cuQydwsmc0KVFAgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qEVZYN0NvVPSVdKoGToIGPoDuIAtbJigc5yNfaUSZqgzCW5haa4VkI+ZUwttAiJzzHX8oKXc3zNMswph3ZFV2k5Wkem7UB+dLOJjVggXOIGwJnKQKzmVITrFPj//X+tJJgaa7aaJ2LQpYqMqhR0acr3IVpFKN/CONnfjBtgE2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=Aeb086lC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="Aeb086lC"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0e521de4eso2189081fa.2
        for <bridge@lists.linux.dev>; Wed, 14 Feb 2024 13:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1707946808; x=1708551608; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KMEBP0pvYWP1lqddz+rz0Za0zJfmlRQq157P1uo0DcI=;
        b=Aeb086lC447X6ayKnbnnqOmHaJd8wjWtpjJgrm44cbcu8EuHSyVHH5FzqOrR1cUmGz
         aPJnG6dPFA8ml+ANVN7sPRX5zwp+eBo2KsEYsqYEdIoOytFQxFWgv0qwjHVvtOgLgBag
         yQAtIt3rPfaN8e6TqZGJi+Pq5TvSVWmCD8gXuv25sDPM119WrvCVE1YMElup3qpcLaSP
         YTj2TCuTKgETsviJWgp+Li5uoUiPx1ISrH+W5/dgzZCWK2pV14oOzSUWmGxxl9fF4F8e
         PHWURWHQ0O9KU+w2GUYYiktZwm3boIkRLlZ9pRX+lKgVwAPno11zL4fN0O/QmSgvSKYF
         K56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946808; x=1708551608;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMEBP0pvYWP1lqddz+rz0Za0zJfmlRQq157P1uo0DcI=;
        b=eWFHx9ThfD1Mf9dKNNgEyn1BLOpKW/eg58F+BGCL9eP7rSWcBSDpiVgg8Wb/NqfdUD
         tBLfL0lYB1A3EV3RapqPkRXjR5Gpv3UIY2nDIDGRmemEnSsa+QgoTPIqjVed0t4SDS6T
         Apv/P1mnamHDiAbhMwZdGreNT4q/kCcgK8FmL1tO62/XqsF4btaa/+ozSoz4dbJjODAy
         E/ZwAzmWoTjdE/FF7n4Ra44ugOzZ5RXQxquwg7jIHhbrtZXm4xWqG2oPhoUuw6sydRuN
         rVmkgeOzPmWFVzohythyWPRsz9w71rI9aOaGcozeo+96Y9+taf4TICZfL9DhgCiWpJdo
         JZzg==
X-Forwarded-Encrypted: i=1; AJvYcCWweiNABIngc7sQC0cinW8N2v3DaHVvH5wU8LAs8IDP0oEj54DJv/zfCezneihELWvUd9k7lGP/SwdOcuuAmq7ZdRBQb+Ed
X-Gm-Message-State: AOJu0Yxa+W70Pr0+r1Bg6/YOeVWQkvQ26AyNpbF+DjZLVhJbFw+u1JUh
	odqAytE1RvZkbR4ANhAdDPLLCZE6EKY71ThR9j2LkpcQtrQXXmFH5n7xnEMlfxKqFLkSVDhl0C1
	A
X-Google-Smtp-Source: AGHT+IGzaiU4dOC9mi7Fpjr5ZD2zzxeAIZ5jWdn90rtQHEA/W7QQAVeb9W7BGhkx3UN+OSTH6uA0XA==
X-Received: by 2002:a19:910c:0:b0:511:ac56:2595 with SMTP id t12-20020a19910c000000b00511ac562595mr37990lfd.2.1707946807992;
        Wed, 14 Feb 2024 13:40:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIZ/E6DfYF53s2qxsiO8AqTSP4vmwqJMbiuLBH0b01MCoXdGN1LRR4MZXaLM+WeqU5iOKIOXCmLahBhc+hR0YxlJ4Ey5W/a4QLExLv3Qp8WumClZrjSGcdPjVO5mmiSKHEcDMlIKKLs++KFKOnUsZxqyw2uLhjPgNhkxxKDhhoWT4w6cSppz/cq4Db1VnRgLVhNXxDek41OpqjYWAU93ge8eBFUcN3vLnWDj89uOc0uC9tqGkhl1Z6kPihJMsg/NDP2P3AEFVxrBHJnVjO7ag6
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id h21-20020a197015000000b005118c6d6a2fsm1433290lfc.305.2024.02.14.13.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 13:40:07 -0800 (PST)
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
Subject: [PATCH v5 net 0/2] net: bridge: switchdev: Ensure MDB events are delivered exactly once
Date: Wed, 14 Feb 2024 22:40:02 +0100
Message-Id: <20240214214005.4048469-1-tobias@waldekranz.com>
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

v4 -> v5:
- Fix grammatical errors in kerneldoc of
  switchdev_port_obj_act_is_deferred

Tobias Waldekranz (2):
  net: bridge: switchdev: Skip MDB replays of deferred events on offload
  net: bridge: switchdev: Ensure deferred event delivery on unoffload

 include/net/switchdev.h   |  3 ++
 net/bridge/br_switchdev.c | 84 ++++++++++++++++++++++++++-------------
 net/switchdev/switchdev.c | 73 ++++++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 28 deletions(-)

-- 
2.34.1

