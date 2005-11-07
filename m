In-Reply-To: <20051107103140.3cc54f3f@localhost.localdomain>
References: <269ECEEB-C04F-45C9-9F16-46ACF4703265@cam.ac.uk>
	<20051107103140.3cc54f3f@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E16AB8CD-63E8-4878-A97F-266F8AA8B835@cam.ac.uk>
Content-Transfer-Encoding: 7bit
From: James Blackburn <fjb31@cam.ac.uk>
Subject: Re: [Bridge] <kernel BUG> generated on bridge up/down & other issues
Date: Mon, 7 Nov 2005 19:45:20 +0000
Sender: James Blackburn <fjb31@hermes.cam.ac.uk>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@lists.osdl.org

Thanks for the prompt response.

>> problem is likely a config issues, but docs appear to be sparse and I
>> can't find much reference to the problem/solution on the 'net; trial
>> and error really isn't working...
> Has this been logged in Ubuntu bug tracker. It would help.

The vtun package is currently unsupported by ubuntu and taken from  
the debian universe.  There's currently a bug (#148808) in the debian  
bug system on vtun's terse documentation.

> Yes, most likely brctl is sending request to vtun
> and it is crashing.

vtun or brctl?  Surely vtun is just connected to the tap0 interface  
and brctl sets up the kernel to bridge between that and eth1?  I  
suppose it only crashes on vtun restart because one (or more) of the  
up/down lines are ordered incorrectly.  Is it valid to remove/add  
interfaces in this order?  Would it be valid to just have tap0  
sitting there with IP 0.0.0.0 and the bridge set up statically?  Is  
there any reason why on initial connection setup brctly show shows  
"can't get port info: Function not implemented", but on restart it  
shows the interfaces correctly?

Sorry for the many questions, just trying to work out how this all  
fits together.  Thanks again for your quick response.

James

