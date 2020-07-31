Return-Path: <komachi.yoshiki@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0m2yM6Cpg0UMGl3JBQ2zB0c8Tu//2IzjG9Zoo6ooaqY=;
 b=hhzBOePGn+ma9oANopuKPFKyVnWTCROJvTFIWKIg+Xqaq5kTw1qad0OqKUKO0yEBSA
 XZtE3/VK2wQHKXopvsveJfyJMOmkUhUJHZ8rooShHKA3F9ArTAWFBJGQ1DZdI6j5V1Di
 Vjt9QY7XhAXpFW67bTCgoR+SUQJ/ikmjbsN3pweNd3qEO+Xjm9IFyo9Lwl+63bMKbw3L
 cSfs4kU+IifQyXiPn0C2XgvPqF2VTmco5iyGcfR8EOWetXpUYze9fuTzsVq1tM9iJNJv
 Lv+pC9TKLh4/uJkCHXTDyWGmF72NLPsK2Er4s8Kc4+V7wi0WxOPulBF1EYC3O5U/UbxU
 gjEw==
From: Yoshiki Komachi <komachi.yoshiki@gmail.com>
Date: Fri, 31 Jul 2020 13:44:17 +0900
Message-Id: <1596170660-5582-1-git-send-email-komachi.yoshiki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [RFC PATCH bpf-next 0/3] Add a new bpf helper for FDB
	lookup
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, KP Singh <kpsingh@chromium.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, bridge@lists.linux-foundation.org, Yoshiki Komachi <komachi.yoshiki@gmail.com>

This series adds a new bpf helper for doing FDB lookup in the kernel
tables from XDP programs. This helps users to accelerate Linux bridge
with XDP.

In the past, XDP generally required users to reimplement their own
networking functionalities with specific manners of BPF programming
by themselves, hindering its potential uses. IMO, bpf helpers to
access networking stacks in kernel help to mitigate the programming
costs because users reuse mature Linux networking feature more easily.

The previous commit 87f5fc7e48dd ("bpf: Provide helper to do forwarding
lookups in kernel FIB table") have already added a bpf helper for access
FIB in the kernel tables from XDP programs. As a next step, this series
introduces the API for FDB lookup. In the future, other bpf helpers for
learning and VLAN filtering will also be required in order to realize
fast XDP-based bridge although these are not included in this series.

Patch 1 adds new function for access FDB in the kernel tables via the
new bpf helper.

Patch 2 adds the bpf helper and 3 adds a sample program.

Yoshiki Komachi (3):
  net/bridge: Add new function to access FDB from XDP programs
  bpf: Add helper to do forwarding lookups in kernel FDB table
  samples/bpf: Add a simple bridge example accelerated with XDP

 include/linux/if_bridge.h      |  11 ++
 include/uapi/linux/bpf.h       |  28 ++++
 net/bridge/br_fdb.c            |  25 ++++
 net/core/filter.c              |  45 +++++++
 samples/bpf/Makefile           |   3 +
 samples/bpf/xdp_bridge_kern.c  | 129 ++++++++++++++++++
 samples/bpf/xdp_bridge_user.c  | 239 +++++++++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |   1 +
 tools/include/uapi/linux/bpf.h |  28 ++++
 9 files changed, 509 insertions(+)
 create mode 100644 samples/bpf/xdp_bridge_kern.c
 create mode 100644 samples/bpf/xdp_bridge_user.c

-- 
2.20.1 (Apple Git-117)

