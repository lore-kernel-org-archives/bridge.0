Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0AC20F5C9
	for <bridge@lists.linux.dev>; Wed, 16 Oct 2024 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091981; cv=none; b=Yfu5cIeC7C5EpeZ+uRg8GWCbmPAy9ic3X6UGLkhVW3wivYKx0n1CzqQzuNcf7DkMaP7FTBFaMgdPBRm6B7qPmOs+GhBUT3aiHqtL9fc64kIWDxJ5L0B5K6S6cdF2jBNEBk4D7DQmqneGLODoXMWyqgLsaQn2NbDhvnM45SbsBew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091981; c=relaxed/simple;
	bh=cXG4LhHB9kVWsQNAFibwspRnoB1deG7zrFUiwm+xwpA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SRek1WGd68xYdm3tvB8exU74vOV3XGvG/DIKslfMvDWFAmiu6CWv8LcGipOjErUbp5Vf+zXoD2xvwuDZ39xeuZZB6qMyQFHAPFtvBAkA3xEKkIIIqehlD2htIpy8+LYnKZnWanWsg5fUTFKho9esdFxrGVM1not4w+qaHzuJRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=uUUG2EAY; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="uUUG2EAY"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3b7442db5so15021025ab.2
        for <bridge@lists.linux.dev>; Wed, 16 Oct 2024 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1729091978; x=1729696778; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xleXnHN4FKfm49u3Y57oNxLsJQFyA18gEpPRQSSO7uY=;
        b=uUUG2EAY+Yo4PF88nz5rcYSjIXg0YwZBfPnItLfLMLma7DxqjTt79c9bzfMQdkFoNR
         bTeTb7tRVfG/4DdOCLHUx6vLiAaNIqgW1JAvgGvyqJTbGjPbZTWfQQE/fCF1W9GGTgOw
         cFlaoPESjd3xmflaBeqoJFf7sktUWsLOH/HJ21xU8yEvpjizvImk+f1+SrUZIqxPzYjI
         9+TlYcIzSBVMoUE14Wq2qfhpB9WGLlIOAdFZEeEUbX3GHy3/O+5RCH2ZS1DYcOKMA6mT
         GJgfSEshsasy+BU13J5TvtqFG8aonmF7b1LwfMAeedjwQq9K60EpFivKQ9iejNHl0plu
         jNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729091978; x=1729696778;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xleXnHN4FKfm49u3Y57oNxLsJQFyA18gEpPRQSSO7uY=;
        b=DRUSHzHcjmcFZZvrbJPFX0EAxiV9KZQMYa0drS0oVHgx9tqiDaNLvHFMiuKAZe2H8j
         lNFDp5C4IezwhNQGQxIajw++FqRz6j+oUKEvbcmZ5ArYsdOmH7e8vFG2yOIoMoDQjv6v
         OXm/vHhEJFOWZr6GvB38aaZlOJfkg6adbVBCKtTXr7lmUZwDovYCB6EWryKuJvxd5oWt
         0rFFHhPGFnys5+W7pqBgnl0TAAVcySbMpMoUHf1Jipxj/RGHgmbqAfXtXWFXsfLDdZVu
         SZrBWgUuKHvt1NTvrSwvo8GJs9PY7Ui0KLjEqU8/wkhklwFPFB14XIej6ysHvnWEBeu3
         lzyw==
X-Gm-Message-State: AOJu0YyDb6xPbARfoZup3N24cI00UtK1/vPBxZtMKlA9JnSU4/S2Zh9J
	XrL934/RV5l9BWT8GOXC7J0tNJrpveXs7/7YVYUAEpV9WViEGtvzuVNpWMj8LrmvoM6UmTx0MZ8
	k
X-Google-Smtp-Source: AGHT+IEySPGvmbrPdn+FgF+BYHEdBpTr2iCmlLbDbNe9GGqTL4iWKqlGcfLNcb3EnmwmNhb8LcPrSg==
X-Received: by 2002:a05:6e02:1561:b0:3a3:a7bf:7f85 with SMTP id e9e14a558f8ab-3a3dc49c453mr46996075ab.5.1729091978100;
        Wed, 16 Oct 2024 08:19:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c7068d1sm3406999a12.75.2024.10.16.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:19:37 -0700 (PDT)
Date: Wed, 16 Oct 2024 08:19:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roopa Prabhu <roopa@nvidia.com>, razor@blackwall.org
Cc: bridge@lists.linux.dev
Subject: Fw: [Bug 198297] Unable to add ethX to bridge if ethX.<VLAN_ID> is
 already present in this bridge
Message-ID: <20241016081936.736e0db7@hermes.local>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Kernel bugzilla new report forwarding to bridge maintainers

Begin forwarded message:

Date: Wed, 16 Oct 2024 06:44:35 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 198297] Unable to add ethX to bridge if ethX.<VLAN_ID> is already present in this bridge


https://bugzilla.kernel.org/show_bug.cgi?id=198297

AntonioBDaniels (annawhuggins@hotmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |annawhuggins@hotmail.com

--- Comment #5 from AntonioBDaniels (annawhuggins@hotmail.com) ---
The bug report on Kernel.org is an issue where adding a physical Ethernet
interface (ethX) to a bridge will fail if a VLAN interface (ethX.<VLAN_ID>) is
already present on that bridge. This issue poses a challenge for users trying
to configure a network
http://www.ralinktech.com/ralink/Home/Backing/Linux.html
https://geometrydash-scratch.com bridge with a VLAN because it conflicts with
the intended network

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
