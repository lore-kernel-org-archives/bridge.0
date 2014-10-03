Return-Path: <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <542DF7DB.6090708@lab.ntt.co.jp>
Date: Fri, 03 Oct 2014 10:11:55 +0900
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
MIME-Version: 1.0
References: <1412294070-11930-1-git-send-email-vyasevic@redhat.com>
	<1412294070-11930-4-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1412294070-11930-4-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 net-next 3/3] bridge: Add filtering support
	for default_pvid
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladislav Yasevich <vyasevich@gmail.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, bridge@lists.linux-foundation.org, Vladislav Yasevich <vyasevic@redhat.com>

On 2014/10/03 8:54, Vladislav Yasevich wrote:
> Currently when vlan filtering is turned on on the bridge, the bridge
> will drop all traffic untill the user configures the filter.  This
> isn't very nice for ports that don't care about vlans and just
> want untagged traffic.
> 
> A concept of a default_pvid was recently introduced.  This patch
> adds filtering support for default_pvid.   Now, ports that don't
> care about vlans and don't define there own filter will belong
> to the VLAN of the default_pvid and continue to receive untagged
> traffic.
> 
> This filtering can be disabled by setting default_pvid to 0.
> 
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>

Acked-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

Thanks,
Toshiaki Makita


