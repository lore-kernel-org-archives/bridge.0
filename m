From: Bart De Schuymer <bdschuym@pandora.be>
Subject: Re: [Bridge] Re: ebtables target to disable an interface
Date: Tue, 12 Aug 2003 01:22:04 +0200
References: <AD59566A9D83864F871AE2E52503064005072C@aimail.aiinet.priv>
In-Reply-To: <AD59566A9D83864F871AE2E52503064005072C@aimail.aiinet.priv>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308120122.04985.bdschuym@pandora.be>
Sender: bridge-admin@lists.osdl.org
Errors-To: bridge-admin@lists.osdl.org
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge/>
To: "Eble, Dan" <DanE@aiinet.com>
Cc: bridge@osdl.org

On Monday 11 August 2003 14:22, Eble, Dan wrote:
> Thanks for the advice.  Still, I would like to avoid using the log to
> communicate between the driver and a process.  What do you think of using a
> netlink socket to send a message from the bridge driver?  (Once it works,
> it could be used for spanning tree control too, as DaveM suggested a while
> back for an alternative to ioctl).
>
> The only problem is I'm not very familiar with netlink sockets.  From what
> I have heard here, though, it sounds like I have a better chance to make a
> netlink socket work properly than to shut down the port from inside the
> kernel without causing a panic, deadlock, or memory leak.

I'm not familiar with them either. But it looks like that's the best solution 
for your problem.

cheers,
Bart

