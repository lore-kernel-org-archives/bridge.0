Return-Path: <pneira@us.es>
Date: Tue, 9 Sep 2014 12:11:48 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20140909101148.GA12123@salvia>
References: <20140907160728.GA4589@salvia>
	<1410178305-28800-1-git-send-email-nicolas.dichtel@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1410178305-28800-1-git-send-email-nicolas.dichtel@6wind.com>
Subject: Re: [Bridge] [PATCH net-next] netfilter: create audit records for
 ebtables replaces
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kaber@trash.net, stephen@networkplumber.org, linux-audit@redhat.com, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, davem@davemloft.net

On Mon, Sep 08, 2014 at 02:11:45PM +0200, Nicolas Dichtel wrote:
> This is already done for x_tables (family AF_INET and AF_INET6), let's do it
> for AF_BRIDGE also.

Applied, thanks Nicolas.
