Message-ID: <AD59566A9D83864F871AE2E525030640050723@aimail.aiinet.priv>
From: "Eble, Dan" <DanE@aiinet.com>
Subject: RE: [Bridge] Re: ebtables target to disable an interface
Date: Fri, 8 Aug 2003 09:23:25 -0400 
MIME-Version: 1.0
Content-Type: text/plain
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
To: bridge@osdl.org

> From: Cameron Simpson [mailto:cs@zip.com.au] 
>
> You could log the event, and monitor the log with a
> 	tail -f logfile | ...
> to turn it off. No extension needed.

Thanks for the suggestion, but it's not the best fit for the system I'm
working in.  (Carrying the reasoning further, I could have the kernel log
*everything* it does and...)

Is there a problem with bringing down the interface from inside?  
