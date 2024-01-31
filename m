Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00A37866D
	for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704556; cv=none; b=osGfLMvImVHAnT7haLnJTmYOSEwvInfYc6/YEVL4j6RVqjjnwkxwh/1lROq6IHCuonmPmrZD8Iy3nYZ52KYIyThfz4olcGJZJHoIqWYvY/rkEPH5NgCPqNXjHJOf+akDNokrASfoyIYHQjJi4/YML7LTjbZvkRJNVmpC/pjl0BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704556; c=relaxed/simple;
	bh=fbxRnYkzwDvN2tNGcLcX2Ze/C02CkXTVSfhqRUOPAr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Faxj40vnOVUuz//RE7Rz5h0VYyolvdEpWp2Zhf+dx8qgkr2ADn8f9vwOBd5v9t7DYLS/gvj+Zooe7a30Rs3XWDwiHYI9BDHkjTsmLOJrlw3h8ql4AwU/lilDCmZDVQ7TVdUj9/wFSNGZA8woUrbI7nWUbOGcTxOiS86HopVaQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=kY8AaenF; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="kY8AaenF"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d04c0b1cacso40095001fa.0
        for <bridge@lists.linux.dev>; Wed, 31 Jan 2024 04:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706704553; x=1707309353; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qbpJcoV5Ju/jfx3qtXGsa0iIXKBX2PL23+obRoZe7RE=;
        b=kY8AaenFZV8WXB9VKvDb8151AjNudDpPPveXkV8vayGe9RvlDnBs2wlabMcVTW03rM
         aQkj1ZU80aAi+NYGQoGJ0/ripziEUDyFmweMBf4StIXTXE5uXh2SbUu8RErCUKTKLT8i
         n6SaTyCuA9y1C6Keo/NqVJW73Zm4SevlQxfMcpMw7SL1aTkMzwBZmRBMPB5UhWcSC9o/
         N81Mnpkmd7PJOpV4Cy3L01qRGNEKGQBjQxLIMLj3SKBC2kMguO8/41bgAVnPwoaNydC4
         0Aea0BGsO/Hyr4ZijxvsddV7rNos626Y8L+fYfdw7DUcl1zapyeBWsOxFrp6PCA2Mrln
         xR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704553; x=1707309353;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbpJcoV5Ju/jfx3qtXGsa0iIXKBX2PL23+obRoZe7RE=;
        b=FhsVQ4FkhOI2+PJe9Vf9TJWp8uum/Ohj47KSOn3RRDmBbArT5YEgUA713g7616S+3P
         8v1WDR8u/20qWJO92Y9pQMy9FrMu8h6YWZeZ5i6YwQCNU2dxM3pcvRPF8PgjsY5V2enS
         +m+WwJDYeLTgvVc5KW0XOJuVyLYhJlfmB/7KSMHN7bGwNuv+mgLvSCG1hcqwE7C4hgZg
         W1vFyB5kxkAqVWtc80nnsuVyZEEteJq1mllsJ3Ir3HRJjXXRSwt51rROHicFxuzlFQQd
         4TOzdPzHFbZE50aa/bO6l9Yj5B25LUunaTpGSvaz1wuAiI6azqQ12TVlvCRzudyhUKa8
         Ik1Q==
X-Gm-Message-State: AOJu0Yyf4KwTbIgE41r4JvfmVvoVxrqHtKW3ShJgUd7BsTmQEdYGOBQd
	XRDSthieAGO09ux+sbB3FSe/ULNxsHpEyt8lZyqiXda6djZxLs7xJJSkdcAGi2o=
X-Google-Smtp-Source: AGHT+IG8hieAfP8LqBvLVUbZvFgBCw7JxwAfevZbKKKcXzdDZs3ZmMq4UXCqyCYWpKJhPmSLAHc72w==
X-Received: by 2002:a2e:b6cd:0:b0:2d0:558e:3d7f with SMTP id m13-20020a2eb6cd000000b002d0558e3d7fmr1057790ljo.33.1706704552632;
        Wed, 31 Jan 2024 04:35:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVrYZFISrOum8i16q9557e4YlIFZHyrBD23OtKrxCCP5eRj0R7VlW66evOtQXYH51xdF6d+EerNaFw6Vyl0RVVNcZfFrmI91frJLpWRFaTYcWepQLn8pgGG5i7MYIlUUtQ0VFXFP0MN5Tj42Q9R7++zvN5aOwsjQemJUIaHTpBC8RgSePqCaA+khMDrCTZ8V+niSnjbvSEnrOmdm88NJKyykbb3kvZ9E7KUnNZg4xjH6SoMTJkFt+ls3oQSQQ==
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9bd5000000b002cdf4797fb7sm1913517ljj.125.2024.01.31.04.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:35:52 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: olteanv@gmail.com,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com
Subject: [PATCH net 0/2] net: bridge: switchdev: Skip MDB replays of pending events
Date: Wed, 31 Jan 2024 13:35:42 +0100
Message-Id: <20240131123544.462597-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Prevent the MDB replay logic from racing with the IGMP/MLD snooping
logic, which can otherwise cause the bridge to generate replays of
events that will also be delivered as regular events. The log message
of 2/2 has all the details.

We choose to preserve events in the deferred queue, eliding the
corresponding replay instead of the opposite. This is important
because purging the deferred event instead, would rob other listeners
of of that event entirely. I.e., regular events are "broadcast" to all
listeners, while replays are "unicast" only to the port joining or
leaving the bridge.

        br0
       /   \
  sw1p0     sw2p0
(hwdom 1) (hwdom 2)

In a setup like above, it is vital that sw1p0 learns about all group
memberships on sw2p0, since it may want to translate such memberships
to host equivalents, in order to let the bridge sofware forward them
to ports in other hardware domains.

Tobias Waldekranz (2):
  net: switchdev: Add helper to check if an object event is pending
  net: bridge: switchdev: Skip MDB replays of pending events

 include/net/switchdev.h   |  3 ++
 net/bridge/br_switchdev.c | 44 +++++++++++++++++-----------
 net/switchdev/switchdev.c | 61 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 17 deletions(-)

-- 
2.34.1

