Return-Path: <christian@brauner.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brauner.io; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=E0BCMKFWF3BD02Wd5RuR4571i9W2UxPN4NomtaxiJf8=;
	b=Pbsrk9Yj+GWVwYq8M7w1YrRXhvtlv6vWVu9wGO2ulnTXBApJWfu1qhBJU0w4egcivp
	K12s6a/oKV2js5QGMSzGu0vPgGV/5c+RQd6VxfGpmcDorv19Dq7DhPPIHwS3bPmxcuyM
	UdxNtuOGe+3vOJwB4afLc4ZS2BYoGJJAV8Ju9z/TZ09ziEqbSZUQ4suyfinpyUIPts0H
	XCXSbRovSubvBnslVaq/5i4yJ+rn8B3odZtsmGPE6tw0GnoXiDhtGNanBl/M0Lcudl2o
	WpfZhJ6ZnmLyrOfhSc2CQfNndf/b6w0szz3r0n85RC/lf0QoISyWmUu17iQeg/corFiZ
	5j/g==
From: Christian Brauner <christian@brauner.io>
Date: Thu,  6 Jun 2019 13:41:40 +0200
Message-Id: <20190606114142.15972-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH RESEND net-next 0/2] br_netfilter: enable in
	non-initial netns
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: davem@davemloft.net, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org
Cc: ueberall@themenzentrisch.de, vapier@chromium.org, richardrose@google.com, nikolay@cumulusnetworks.com, joelhockey@chromium.org, roopa@cumulusnetworks.com, fw@strlen.de, linux-kernel@vger.kernel.org, tyhicks@canonical.com, bhthompson@google.com, Christian Brauner <christian@brauner.io>, kadlec@blackhole.kfki.hu, smbarber@chromium.org, pablo@netfilter.org

Hey everyone,

This is another resend of the same patch series. I have received so many
requests, pings, and questions that I would really like to push for this
again.

Over time I have seen multiple reports by users who want to run applications
(Kubernetes e.g. via [1]) that require the br_netfilter module in
non-initial network namespaces. There are *a lot* of issues for this. A
shortlist including ChromeOS and other big users is found below under
[2]! Even non-devs already tried to get more traction on this by
commenting on the patchset (cf. [3]).

Currently, the /proc/sys/net/bridge folder is only created in the
initial network namespace. This patch series ensures that the
/proc/sys/net/bridge folder is available in each network namespace if
the module is loaded and disappears from all network namespaces when the
module is unloaded.
The patch series also makes the sysctls:

bridge-nf-call-arptables
bridge-nf-call-ip6tables
bridge-nf-call-iptables
bridge-nf-filter-pppoe-tagged
bridge-nf-filter-vlan-tagged
bridge-nf-pass-vlan-input-dev

apply per network namespace. This unblocks some use-cases where users
would like to e.g. not do bridge filtering for bridges in a specific
network namespace while doing so for bridges located in another network
namespace.
The netfilter rules are afaict already per network namespace so it
should be safe for users to specify whether a bridge device inside their
network namespace is supposed to go through iptables et al. or not.
Also, this can already be done by setting an option for each individual
bridge via Netlink. It should also be possible to do this for all
bridges in a network namespace via sysctls.

Thanks!
Christian

[1]: https://github.com/zimmertr/Bootstrap-Kubernetes-with-Ansible
[2]: https://bugs.chromium.org/p/chromium/issues/detail?id=878034 
     https://github.com/lxc/lxd/issues/5193
     https://discuss.linuxcontainers.org/t/bridge-nf-call-iptables-and-swap-error-on-lxd-with-kubeadm/2204
     https://github.com/lxc/lxd/issues/3306
     https://gitlab.com/gitlab-org/gitlab-runner/issues/3705
     https://ubuntuforums.org/showthread.php?t=2415032
     https://medium.com/@thomaszimmerman93/hi-im-unable-to-get-kubeadm-init-to-run-due-to-br-netfilter-not-being-loaded-within-the-5642a4ccfece
[3]: https://lkml.org/lkml/2019/3/7/365

Christian Brauner (2):
  br_netfilter: add struct netns_brnf
  br_netfilter: namespace bridge netfilter sysctls

 include/net/net_namespace.h          |   3 +
 include/net/netfilter/br_netfilter.h |   3 +-
 include/net/netns/netfilter.h        |  16 +++
 net/bridge/br_netfilter_hooks.c      | 166 ++++++++++++++++++---------
 net/bridge/br_netfilter_ipv6.c       |   2 +-
 5 files changed, 134 insertions(+), 56 deletions(-)

-- 
2.21.0

