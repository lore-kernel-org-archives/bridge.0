Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D529327BEC
	for <bridge@lists.linux.dev>; Sat, 27 Jun 2026 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782567060; cv=none; b=FCpLhlgL+kjn1q1vog1UWWFZjggbTpaIgPKuhG/RyoJ+GG2sO/6gYTCqmCf2GvtEwH2ZCuFIb/2mXBPu+MAs5T+RGmFG9o2bR+r8zRSbgJb+8zKZg0K9sW91Xw0vR5AJoJqm8C6ng2rnQDIcO4MSGll0Romx9yE6rQSQsZXwjl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782567060; c=relaxed/simple;
	bh=KsfSqqfjYjdrTEywzPG+vZec0FaK/PzKcLvf//wJplM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VBssUuL/Ir1R4P3WZziZOy688rTrdRJ51fm0IRPNoWCqll/PUerFf9PwObYUtT+xLcxBztopasZp1bJtk1f1lpJ5cPNf7nZZwlV2FOxfXgZABgc4oFd/FawPLIhmUUvtCeMiUy6qjXiL2SmGbYOVqYoUi3GpDtkCq+4tNHge4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=QRzWDQO/; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="QRzWDQO/"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 44003fdf3;
	Sat, 27 Jun 2026 21:25:44 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Question: bridge: clarify MST VLAN list RCU traversal contract
Date: Sat, 27 Jun 2026 21:25:39 +0800
Message-Id: <20260627132539.3701630-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f0941f21903a1kunm6870078cd1180
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTRhJVhodTBhPGRpKGkkdS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QRzWDQO/9WPdeQzsbZ30FreXwoqG7XekJtbKubt9eBc0W27gC/4yca4rDkf3xpDWPy3oZsgPCTg2nCtPatabQ5SHNJDpHKr07J4roVd6NhvIUv0uclmtFqb7S5F4Pcei8oX9N/GUH1xYre2EujBMESof+JfTwaMnJnYhFhO8W2U=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=aGEZ6gZtMKGo9wdTJQLn/OJG9o5Lvqyo3f6OLohy5u8=;
	h=date:mime-version:subject:message-id:from;

Hi bridge maintainers,

This question comes from a candidate found by our static analysis tool
and then manually reviewed against the current tree. The audit used
CONFIG_PROVE_RCU_LIST as target-matched triage evidence; I am asking
for maintainer guidance because the source-level review did not prove
a use-after-free.

A CONFIG_PROVE_RCU_LIST audit flags the VLAN-list traversal in
br_mst_info_size():

  net/bridge/br_mst.c:251 br_mst_info_size()

The helper walks vg->vlan_list with list_for_each_entry_rcu().  In the
direct local context, br_get_link_af_size_filtered() first enters an
RCU read-side section, resolves the bridge port or bridge VLAN group,
and calls br_get_num_vlan_infos(vg, filter_mask).  That local RCU
read-side section is then dropped before the later MST sizing call:

  net/bridge/br_netlink.c:104 rcu_read_lock()
  net/bridge/br_netlink.c:113 br_get_num_vlan_infos(vg, filter_mask)
  net/bridge/br_netlink.c:114 rcu_read_unlock()
  net/bridge/br_netlink.c:123 br_mst_info_size(vg)

The helper is registered through rtnl_af_ops.get_link_af_size, and
bridge VLAN updates appear RTNL-centered, so the broader rtnetlink
sizing path may already provide the intended serialization.  I am not
claiming a use-after-free here.  The question is only whether the
RCU-list traversal contract around br_mst_info_size() should be made
explicit enough for CONFIG_PROVE_RCU_LIST to see it.

Would you prefer one of these directions?

  1. keep the MST sizing loop inside an explicit rcu_read_lock() in
     br_get_link_af_size_filtered();

  2. pass a confirmed RTNL lockdep condition to the iterator in
     br_mst_info_size();

  3. document that the outer rtnetlink sizing path is the required
     protection and leave the helper unchanged;

  4. use a different bridge-specific pattern.

I am intentionally sending this as a maintainer question rather than a
patch because the right contract seems to depend on the bridge/rtnetlink
caller semantics.

Thanks.
