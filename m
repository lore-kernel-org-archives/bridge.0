Message-Id: <s0ab408a.045@EMAIL>
Date: Wed, 19 May 2004 11:09:58 +0530
From: "Kishore A K" <kishoreak@myw.ltindia.com>
Subject: Re: [Bridge] BPDU generation problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: shemminger@osdl.org
Cc: bridge@lists.osdl.org

Hi Stephan,

But is it not a serious bug cause it is going to the affect the topology of the 
entire network on to which the bridge is connected..

Regards,
Kishore



>>> Stephen Hemminger <shemminger@osdl.org> 05/18/04 09:24PM >>>
On Tue, 18 May 2004 21:18:01 +0530
"Kishore A K" <kishoreak@myw.ltindia.com> wrote:

> Hi Stephen,
> 
> I have been studying the bridge source & analyzing its flow by putting printks
> at various places. I am using kernel 2.6.6. I found something really strange 
> happening..
> 
> I have setup a bridge with two ports. I havent enabled stp on the bridge. Which
> I have confirmed by doing a "brctl show" also. However from the printks I find 
> that BPDUs are getting generated & sent on the ports. Isnt this not supposed to 
> happen?
> 
> Regards,
> Kishore

Probably just a stupid bug. 


