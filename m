Date: Wed, 28 Jan 2004 10:01:06 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040128100106.6c52ee20.shemminger@osdl.org>
In-Reply-To: <40170C13.1070202@nortelnetworks.com>
References: <40170C13.1070202@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: Adding same physical port to multiple bridges
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Abhijit Kumbhare <abhijitk@nortelnetworks.com>
Cc: bridge@osdl.org

On Tue, 27 Jan 2004 17:10:43 -0800
Abhijit Kumbhare <abhijitk@nortelnetworks.com> wrote:

> Hi,
> 
> Is there any particular reason why the same physical port cannot be 
> added to multiple bridges? Is it because of STP?

Not just STP, but all the data structures in the code are set up
1-N.  For example, there is a pointer in the netdevice structure that
contains the bridge to handle the received packet.  What would it mean
to be part of multiple bridges? Would received packets be process N times
by each bridge? 

> If I am not using STP - can I change the code to have the same physical 
> port in 2 VLANs? Is that a safe change?

Probably not. What are you trying to do?  Might to be bridge the
physical LAN and do any filtering based on tag using bridge-filtering
(ebtables).

-- 
Stephen Hemminger 		mailto:shemminger@osdl.org
Open Source Development Lab	http://developer.osdl.org/shemminger
