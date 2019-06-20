Return-Path: <pablo@netfilter.org>
Date: Thu, 20 Jun 2019 12:20:40 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20190620102040.g5yqqp3lnka7rn3q@salvia>
References: <20190619170547.6290-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619170547.6290-1-christian@brauner.io>
Subject: Re: [Bridge] [PATCH net-next] br_netfilter: prevent UAF in
	brnf_exit_net()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Christian Brauner <christian@brauner.io>
Cc: heiko@sntech.de, narmstrong@baylibre.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org, a.hajda@samsung.com, laurent.pinchart@ideasonboard.com, sam@ravnborg.org, sfr@canb.auug.org.au, nikolay@cumulusnetworks.com, bridge@lists.linux-foundation.org, patrik.r.jakobsson@gmail.com, kadlec@netfilter.org, maxime.ripard@bootlin.com, coreteam@netfilter.org, airlied@redhat.com, harry.wentland@amd.com, roopa@cumulusnetworks.com, jonas@kwiboo.se, marc.zyngier@arm.com, syzkaller-bugs@googlegroups.com, intel-gfx@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com, alexander.deucher@amd.com, rodrigo.vivi@intel.com, jerry.zhang@amd.com, sean@poorly.run, netdev@vger.kernel.org, fw@strlen.de, linux-kernel@vger.kernel.org, christian.koenig@amd.com, syzbot+43a3fa52c0d9c5c94f41@syzkaller.appspotmail.com, netfilter-devel@vger.kernel.org, daniel@ffwll.ch, enric.balletbo@collabora.com, davem@davemloft.net

On Wed, Jun 19, 2019 at 07:05:47PM +0200, Christian Brauner wrote:
> Prevent a UAF in brnf_exit_net().

Applied, thanks.
