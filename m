Return-Path: <stephen.hemminger@vyatta.com>
Date: Fri, 07 Dec 2012 09:07:22 -0800 (PST)
From: Stephen Hemminger <stephen.hemminger@vyatta.com>
Message-ID: <1a884874-7123-401f-a53c-cc8e301b1ffe@tahiti.vyatta.com>
In-Reply-To: <1354850623-31652-2-git-send-email-amwang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v4] iproute2: add mdb sub-command to bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, Jesper Dangaard Brouer <brouer@redhat.com>, Thomas Graf <tgraf@suug.ch>, "David S. Miller" <davem@davemloft.net>



> 
> 	# ./bridge/bridge mdb
> 	bridge br0:
> 	port eth0, group 224.8.8.9
> 	port eth1, group 224.8.8.8

I like the ability to see what is going on. It would
be good if there was also a monitor like hook to see new entries
created and destroyed (later version).

The output format should be one line per entry for easier
parsing by utilities. Something similar to 'ip neigh show'

