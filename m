Date: Tue, 1 Dec 2009 08:32:02 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20091201083202.719890c6@nehalam>
In-Reply-To: <cfeab66d0912010626n43e2a971gdc8a23b976256c56@mail.gmail.com>
References: <cfeab66d0912010626n43e2a971gdc8a23b976256c56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] notifier chain on br0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: ratheesh k <ratheesh.ksz@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Tue, 1 Dec 2009 19:56:03 +0530
ratheesh k <ratheesh.ksz@gmail.com> wrote:

> Hi All ,
> 
>  i  have a software bridge br0 on eth0 and eth1 . Can i use NETLINK
> sockets to get ip address change notification on br0 .???
> 
> Thanks,
> Ratheesh

Netlink reports all interfaces including br0
