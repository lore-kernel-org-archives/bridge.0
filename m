Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9491917D4
	for <bridge@lists.linux.dev>; Fri,  7 Feb 2025 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965857; cv=none; b=bP7/OhqOiTsB/qtXewYvbDLz8HLMc/cLkmIa4k/ExHmCFLSD4oUBM4b/8atiL4zKGFW7vE7ihSG139G5U2ikgHByFhRCP3hmNgE7LGIq7Y+JcOa+plHyzWhny3H5rONYuZXexdIGGF8XvNyFFbfNEV/y1SpsDf8xTptFEi+6MoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965857; c=relaxed/simple;
	bh=TDZV89AOBX2YFKVlPXOJAgBnc75fsPEzxH92JaUjJ4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/6cF9fTCF8xdZFp9p2CEioe6AgBvDQuiD8I/alA4jmGfBFIsVvQ/pgNwg60EQQM4foa7qCPc1svWKi0846qICAXsO9Kenf2WFhvxk8nVft4QVEYMnwPuldqdBW1Gk6qcZXvxbLYVOHvrssPF0GiDcLCa6z73ojVQLA+Ano1MIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z63GxfgR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z63GxfgR"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab74fb599c1so44097566b.0
        for <bridge@lists.linux.dev>; Fri, 07 Feb 2025 14:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738965852; x=1739570652; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9p4ESdWoXjaib9fV4OUyBdDHqaUGl8KIiJHqtkdvtBw=;
        b=Z63GxfgRYmMTyK372WItAKe9FBKsT1Wie0HlBHLiLhyFh3o5DhQ12/hf1u5fQpAFng
         62MbJB203Kq0SMhSxyTwnDvhArWMA/9XVjDjh6DG+H+heCFBJ5quxFE8yM2aintZMBx7
         vETg9MB4W+ZmC/A5gix7jyPefph5DLQye0S2bu0pBN1hfkzjDAJAt/cgSCWUWOrefbZk
         5/Zm6jCQ4juxz8PucthBJ5g6cb6CHh47mmkJwLkaRd2YCs3zI7RurTX9HLE3Y/AHFGf5
         prd9a9TtFWARn9ETkO721izACLz+6xhK8Buer0Y1tT3wT27YDOlfwlV0xCGl7vHCk/40
         LTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738965852; x=1739570652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9p4ESdWoXjaib9fV4OUyBdDHqaUGl8KIiJHqtkdvtBw=;
        b=Q+xJtd3St4gkbXM6R3vfA92EYu/BqVd5bh3OsP+w5lFpEmPo9h8GavTkB595VdMeTz
         CwUaLZz9gZjJengTMvemzgHrNs1QMVaIqx2ZaqLU0spPdFB3fL0NZJCCaN3yTFkqjKvp
         sTp2ymD/t6HmyOoVerFv4MdkidPNhZ7DnQ6CZhbMboK1Tsw3rFVJgrT1e2JDSV+qBw0b
         6Ca2TK/wKZOAw0mButpe00JbCpEgyvk3KE7fgP9Y27gQEoipxtzT4dlDNOoZ1FGjwIAt
         siM82jPKJ+fjB5OZ3NUPfRN+JpSMQ9IeqpX5hFNUzeCoZDbQQXUNJIOidAk69PZWCIW6
         dG9g==
X-Forwarded-Encrypted: i=1; AJvYcCUqpPPj+vCEgZZMVmFqKLC+GHXfjEIcxwdVbEcnhSYmjeMxsnBbvEEE2e764xuFVm+P6KlNj6g=@lists.linux.dev
X-Gm-Message-State: AOJu0YyC0yfAjNSgb/9Oj70TQlusoZd57yhoigii7s8A7kJLEGMwAIpU
	xmSlfqeRQpcDjY4l2c2ZLvPg2l8G/8CTfWqo+hTTZAaf6/GV85Rj
X-Gm-Gg: ASbGncvi02ra+sfFEw/IepfisFtmoSPAaOjtFeGHE9kgVTXFHwSG1nYOsqJrIF8OpRf
	FiRuLxaq1wVlJ6YEXzG/RDFXdYeTDmd7LYOfmzea0kasqO1VkI+POBhCZUoOFTBpSSFcG3+n90J
	t7IwWuAJA8bu7XMQxwVBopWk1w89yg3XPtMaN8HmEA2dH6jxxkwky1ZPknFwdc7o1oJa3QJz7CY
	g2jh2RcFO6md0jGczcVjHYyQjzdup1eXPoElPHhsMi/mi4LAYveinjOOkruUxpecKig1wOo9JKu
	Qac=
X-Google-Smtp-Source: AGHT+IFsi3+NWjssSKSXZEmvjnEsxFYODgK8SKJ6cgvDO7NhfH/SlmKt0XPdmk4uFCMFK0SjvH4aEg==
X-Received: by 2002:a17:907:7fa8:b0:ab6:3b87:d32a with SMTP id a640c23a62f3a-ab789c2f3d7mr190605566b.11.1738965852001;
        Fri, 07 Feb 2025 14:04:12 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773337e98sm337699266b.151.2025.02.07.14.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 14:04:11 -0800 (PST)
Date: Sat, 8 Feb 2025 00:04:08 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 net-next 12/14] bridge: No DEV_PATH_BR_VLAN_UNTAG_HW
 for dsa foreign
Message-ID: <20250207220408.zipucrmm2yafj4wu@skbuf>
References: <20250204194921.46692-1-ericwouds@gmail.com>
 <20250204194921.46692-13-ericwouds@gmail.com>
 <20250207150340.sxhsva7qz7bb7qjd@skbuf>
 <78a30eab-cae6-4026-b701-7d7002fe3abb@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a30eab-cae6-4026-b701-7d7002fe3abb@gmail.com>

On Fri, Feb 07, 2025 at 09:04:28PM +0100, Eric Woudstra wrote:
> Or should mlxsw_sp_switchdev_blocking_event() use
> switchdev_handle_port_obj_add_foreign() to add the vxlan
> foreign port?
> 
> Then all foreign ports are added in a uniform manner and
> SWITCHDEV_F_NO_FOREIGN is respected.
> 
> I do not have the hardware to test any changes in that code.

Personally, in your place I wouldn't have the courage to refactor that
much in a driver as complex as spectrum, but if you CC the right people
from Nvidia who can test, I guess you could give that a try.

Actually, how I came to spectrum was that I was thinking about an
alternative mechanism of detecting "foreign or not", other than emitting
two switchdev notifiers. You emit just the usual, single one, but
whoever handles it for a foreign bridge port will set a new bool
port_obj_info->handled_by_foreign, very similar to the existing
bool port_obj_info->handled. I was looking around to see who else
open-codes the switchdev object handling rather than use the
switchdev_handle_*() helpers, and that's how I came across spectrum.
It would seem, at first glance, easier to set just this in spectrum:

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 6397ff0dc951..6926aaae7278 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -3953,6 +3953,7 @@ mlxsw_sp_switchdev_vxlan_vlans_add(struct net_device *vxlan_dev,
 		return 0;
 
 	port_obj_info->handled = true;
+	port_obj_info->handled_by_foreign = true;
 
 	bridge_device = mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
 	if (!bridge_device)

and this in the object replication helper:

diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index c48f66643e99..be82e79b5feb 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -763,6 +763,8 @@ static int __switchdev_handle_port_obj_add(struct net_device *dev,
 	if (!foreign_dev_check_cb(switchdev, dev))
 		return err;
 
+	port_obj_info->handled_by_foreign = true;
+
 	return __switchdev_handle_port_obj_add(br, port_obj_info, check_cb,
 					       foreign_dev_check_cb, add_cb);
 }

Just some care needs to be taken to only consider "handled_by_foreign"
just when "handled" is true.

I haven't yet decided which variant I like better, just thought I'd
mention this as something which requires a single switchdev notification.

Anyway, in the future I'll have to do some more tweaks with these flags
in the context of LAG. These flags (BR_VLFLAG_ADDED_BY_SWITCHDEV, now
also BR_VLFLAG_TAGGING_BY_SWITCHDEV after this patch) can dynamically
change, and the existing code isn't great because it doesn't handle that.

For example:

ip link add br0 type bridge
ip link set swp0 master br0
ip link set bond0 master br0 # bond0 is a foreign interface to swp0 at this time
bridge vlan add dev bond0 vid 100 # this won't get BR_VLFLAG_TAGGING_BY_SWITCHDEV
ip link set swp1 master bond0 # bond0 is no longer a foreign interface to swp0, assuming the same phys_switch_id
# vid 100 should get BR_VLFLAG_TAGGING_BY_SWITCHDEV during br_switchdev_vlan_replay()

Considering that br_switchdev_vlan_replay() will need to re-evaluate the
BR_VLFLAG_TAGGING_BY_SWITCHDEV flag, I guess I do prefer the simpler
variant after all - it is one call less that will have to be made during
replay as well.
