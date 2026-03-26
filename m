Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A914B393DD3
	for <bridge@lists.linux.dev>; Thu, 26 Mar 2026 03:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774496713; cv=none; b=DVbAfkpZC84B2269rjlZFazJ5GLtDU2dZBcR1e3c5MLsLPsbEC9G9sTRvssb0iMzT96Iq3CYf/KpsNsgoILfgLJdYZ6k4r+pSzsVRvE6WAOMnDYDx+6mXaRF3PFU/IkHs87lSil9KCMt4gnCidmv3jkfaIzXWnUAi8mUdEcNq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774496713; c=relaxed/simple;
	bh=GMAv5MzVfRwGd39KM2jFV1VroHQGiDUZseciuLYp56k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOCKC+mdSuWxLkbiXFxEyOf9N2hgN5f69N3ItWsgKmk/EqbeDocaz1hi1D4WatuNxmTdnvmtOFQ1sAgelb284LZ02lXScMvoELUZsiDZ8vWEyMKlm0+T4dpwdlhQLZMsE/h7umIxPNTakg8NfmRRKHjXCRlc3lHw1maf2ojd4CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from a800-server-1.tail7779b.ts.net (unknown [172.30.111.252])
	by app1 (Coremail) with SMTP id ygmowABXyvqpq8RpxwyKAA--.44467S2;
	Thu, 26 Mar 2026 11:44:41 +0800 (CST)
From: Yang Yang <n05ec@lzu.edu.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	razor@blackwall.org,
	idosch@nvidia.com
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	florian.fainelli@broadcom.com,
	roopa@cumulusnetworks.com,
	dlstevens@us.ibm.com,
	nb@tipi-net.de,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	tanyuan98@outlook.com,
	bird@lzu.edu.cn,
	n05ec@lzu.edu.cn
Subject: [PATCH net 0/3] bridge/vxlan: harden ND option parsing paths
Date: Thu, 26 Mar 2026 03:44:38 +0000
Message-ID: <20260326034441.2037420-1-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowABXyvqpq8RpxwyKAA--.44467S2
X-Coremail-Antispam: 1UD129KBjvdXoWrGr13CFy5Cr4xWr4ktryDAwb_yoWxWwb_Wa
	4vyry8GrW8Zas8GFyfWFW5ArykC3yj9F4kZ39F9rZxJws0vr4qkrs7XF9xXF4DJF4xGry3
	Kr4qyw4fXwnIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWUuVWrJwAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRMXdjDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQQSCWnEBPoIxgAAsD

Hi,

This series hardens ND option parsing in bridge and vxlan paths.

Patch 1 linearizes the request skb in br_nd_send() before walking ND
options. Patch 2 adds explicit ND option length validation in
br_nd_send(). Patch 3 adds matching ND option length validation in
vxlan_na_create().

Thanks.

Yang Yang (3):
  bridge: br_nd_send: linearize skb before parsing ND options
  bridge: br_nd_send: validate ND option lengths
  vxlan: validate ND option lengths in vxlan_na_create

 drivers/net/vxlan/vxlan_core.c |  6 ++++--
 net/bridge/br_arp_nd_proxy.c   | 18 +++++++++++-------
 2 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.43.0

