Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 28 May 2015 18:42:44 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150528164243.GE2827@odroid>
References: <1432813374.16878.5.camel@edumazet-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1432813374.16878.5.camel@edumazet-glaptop2.roam.corp.google.com>
Subject: Re: [Bridge] [PATCH net] bridge: fix br_multicast_query_expired()
	bug
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: "Steinar H. Gunderson" <sesse@samfundet.no>, netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>, David Miller <davem@davemloft.net>

On Thu, May 28, 2015 at 04:42:54AM -0700, Eric Dumazet wrote:
> Intent of the code was to clear port field, not the pointer to querier.

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
