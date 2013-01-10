Return-Path: <shemminger@vyatta.com>
Date: Thu, 10 Jan 2013 14:10:05 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20130110141005.427ccaf9@nehalam.linuxnetplumber.net>
In-Reply-To: <50EF1537.7030209@redhat.com>
References: <1357751882-8619-1-git-send-email-vyasevic@redhat.com>
	<1357751882-8619-3-git-send-email-vyasevic@redhat.com>
	<20130110103614.23383079@nehalam.linuxnetplumber.net>
	<50EF0FF7.3080407@redhat.com> <50EF1537.7030209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v5 02/14] bridge: Add vlan filtering
 infrastructure
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vyasevic@redhat.com
Cc: mst@redhat.com, netdev@vger.kernel.org, stephen@redhat.com, bridge@lists.linux-foundation.org, shmulik.ladkani@gmail.com, davem@davemloft.net

The problem with your approach is that it 
adds a hash lookup in the packet process critical path.

Also the concept of different filters for egress vs ingress is feature
madness. It doesn't make sense to have half-duplex connectivity.



