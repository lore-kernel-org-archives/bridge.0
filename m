MIME-Version: 1.0
Date: Tue, 27 Jan 2009 13:52:25 +0200
Message-ID: <8ffbf9ad0901270352iff6091cg9751c3d16ab5cea1@mail.gmail.com>
From: aras as <arunelis007@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Bridge]  Multiple vconfig
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

> Hi,
>
> I did the following:
>
> vconfig add eth0 10
> I got interface eth0.10
> Then I did:
> vconfig add eth0.10 11
> I got inteface eth0.10.11
>
> Anyone imagine which kind of packets will come out over the wire, double
> tagged packets?
>
> Bye,
> Antonio.
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: http://lists.linux-foundation.org/pipermail/bridge/attachments/20090110/9308ad42/attachment.htm


You will get Q-in-Q (double vlan) package. I can do even eth0.10.11.12
and so on. But you should not forget that every vlan tag adds 4baits
in ethernet package.
