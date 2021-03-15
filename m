Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1RURcpmMch727Ry8e1e4rE7LPwmwCCm3CKQbXHTVP1k=;
 b=VjaRKYrlU6zrK4i5Dbl2mp11CL4okopm1GnZdyIJPuqiQoK/zuwrDKG6RGT7Ebx9k/
 j3yGlADue1PlYQ8x2ktROsbItQVr/mvzwaHP1oTK4pCiPWmGVD8n6tQb8FieUxwim3wO
 5CO2+rbqDjn8jTgTV8V/S4bGDN4QRWw5wfw8BkW28E4uMu6GnpuWF1dFnoKOR+ZmdoFt
 3ljn5xKw8RMOTANCOA33zD410Jr8TEXekSsReLhFyZwIN2T4En4qJeYqNLLFeBkS3kic
 12cf/JjXcGm1rwa8i3rgO9X4uUIqfRDALgr8c2nEWvA5tJvKsc79E6zDpAylSUtZsWFF
 19/w==
From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Mon, 15 Mar 2021 19:13:40 +0200
Message-Id: <20210315171342.232809-1-razor@blackwall.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 0/2] net: bridge: mcast: simplify
	allow/block EHT code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, kuba@kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>

Hi,
The set does two minor cleanups of the EHT allow/block handling code:
patch 01 removes code which is unreachable (it was used in initial EHT
versions, but isn't anymore) and prepares the allow/block functions to be
factored out. Patch 02 factors out common allow/block handling code.
There are no functional changes.

v2: send patch 02 and the proper version of both patches

Thanks,
 Nik

Nikolay Aleksandrov (2):
  net: bridge: mcast: remove unreachable EHT code
  net: bridge: mcast: factor out common allow/block EHT handling

 net/bridge/br_multicast_eht.c | 141 +++++++++-------------------------
 1 file changed, 35 insertions(+), 106 deletions(-)

-- 
2.29.2

