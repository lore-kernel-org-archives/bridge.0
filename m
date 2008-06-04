Message-ID: <2b38e39a0806041500t645fa6e4raaf8c20d971733df@mail.gmail.com>
Date: Wed, 4 Jun 2008 15:00:27 -0700
From: "yordanos beyene" <yordanosb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] linux bridging to forward traffic from physical to virtual
	interface of my linux box
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all,

I am new to Linux Bridge, and need some help.
I am trying to use Linux bridge (brctl) and ebtables to forward
incoming frames from my local interface into a set of virtual
interfaces in my linux box. I believe "ebtables" can be used to
selectively forward packets to virtual interfaces- for instance, based
on the source mac address of the frame (or source interface of frame).
I have created virtual interfaces but I am not able to add the virtual
interfaces to the bridge. I can i can only add physical interfaces.

Can any one advice me if Linux bridge works with virtual interfaces?
Let me know if you have any idea on this or other better mechanism.

Thanks.
Jordi
