Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=jSTLEPaxXRk5sSmG9oSsPXFVdXLQlUfBUPDhCvkx5go=;
	b=RlJIncS5V/VeZ8tPU8EEBpDu0ecPVdk1TB589EL92OS3o6Lj/2CpEeDsKsB6b618GV
	8L3X3n1laq2hQ/uB/NIkih6WDZyT5owW4NktaFEqJOQeK6yQN3cufbWoZnaHcSDpgim7
	sLB18ckMTXbKNu2euww+eB/lnbRZu4oTB+QR8=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri,  1 Nov 2019 14:46:36 +0200
Message-Id: <20191101124639.32140-1-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net-next v2 0/3] net: bridge: minor followup
	optimizations
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Hi,
After the converted flags to bitops we can take advantage of the flags
assignment and remove one test and three atomic bitops from the learning
paths (patch 01 and patch 02), patch 03 restores the unlikely() when taking
over HW learned entries.

v2: a clean export of the latest set version

Thanks,
 Nik


Nikolay Aleksandrov (3):
  net: bridge: fdb: br_fdb_update can take flags directly
  net: bridge: fdb: avoid two atomic bitops in
    br_fdb_external_learn_add()
  net: bridge: fdb: restore unlikely() when taking over externally added
    entries

 include/trace/events/bridge.h | 12 ++++++------
 net/bridge/br_fdb.c           | 30 +++++++++++++++---------------
 net/bridge/br_input.c         |  4 ++--
 net/bridge/br_private.h       |  2 +-
 4 files changed, 24 insertions(+), 24 deletions(-)

-- 
2.21.0

