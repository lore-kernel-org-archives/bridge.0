Return-Path: <davem@davemloft.net>
Date: Tue, 11 Jun 2013 02:05:04 -0700 (PDT)
Message-Id: <20130611.020504.1812928863778377675.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1370441281-11281-1-git-send-email-vyasevic@redhat.com>
References: <1370441281-11281-1-git-send-email-vyasevic@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCHv4 net-next 0/2] Add two new flags to bridge.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: vyasevic@redhat.com
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org

From: Vlad Yasevich <vyasevic@redhat.com>
Date: Wed,  5 Jun 2013 10:07:59 -0400

> The following series adds 2 new flags to bridge.  One flag allows
> the user to control whether mac learning is performed on the interface
> or not.  By default mac learning is on.
> The other flag allows the user to control whether unicast traffic
> is flooded (send without an fdb) to a given unicast port.  Default is
> on.

Series applied, thanks.
