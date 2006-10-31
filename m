Message-ID: <20061031112113.24306.qmail@web56902.mail.re3.yahoo.com>
Date: Tue, 31 Oct 2006 03:21:13 -0800 (PST)
From: Douglas Chen <g5ranger@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] problem with bridge on soho router,
	when lan interface down, all go down
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Hi again Stephen,


>The bridge disables by port, each port is a network device. If the network devices
>correctly implement carrier, then it can work with some down and some up.
>It sounds like either they are all coming on one device, or the device driver is
>buggy.


I think you hit the jackpot!  I looked into the driver code and the carrier is not implemented as it is supposed to.  Whenever there is a LAN port status change, the change is used to set the carrier.  This is the reason why when one port is disconnected, it brings down the whole interface.  I've changed that to check the status of other ports before setting the carrier flag.  

Thank you very much!!  You are a big help!

Douglas



