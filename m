Return-Path: <pablo@netfilter.org>
Date: Mon, 17 Jun 2019 15:34:40 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190617133440.mhnhtcwwraf53bl4@salvia>
References: <20190610212606.29743-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610212606.29743-1-christian@brauner.io>
Subject: Re: [Bridge] [PATCH net-next v2 0/2] br_netfilter: enable in
	non-initial netns
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christian Brauner <christian@brauner.io>
Cc: ueberall@themenzentrisch.de, vapier@chromium.org, richardrose@google.com, bhthompson@google.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, joelhockey@chromium.org, tyhicks@canonical.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, smbarber@chromium.org, davem@davemloft.net

On Mon, Jun 10, 2019 at 11:26:04PM +0200, Christian Brauner wrote:
[...]
> Over time I have seen multiple reports by users who want to run applications
> (Kubernetes e.g. via [1]) that require the br_netfilter module in
> non-initial network namespaces. There are *a lot* of issues for this. A
> shortlist including ChromeOS and other big users is found below under
> [2]! Even non-devs already tried to get more traction on this by
> commenting on the patchset (cf. [3]).
> 
> Currently, the /proc/sys/net/bridge folder is only created in the
> initial network namespace. This patch series ensures that the
> /proc/sys/net/bridge folder is available in each network namespace if
> the module is loaded and disappears from all network namespaces when the
> module is unloaded.

Series applied, thanks Christian.
