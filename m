Return-Path: <cole@coledd.com>
Date: Tue, 31 Jan 2012 11:40:19 -0500
From: Christopher Cole <cole@coledd.com>
Message-ID: <20120131164019.GA12262@coledd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] setfd
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bridge@lists.linux-foundation.org

I have a bridge working between a wired Ethernet and a Wifi interface.  
However, it takes 80 seconds before it actually starts passing data.  I 
tried to reduce this learning delay by minimizing the forwarding delay:

 brctl setfd br0 0

But the above has zero effect on the 80 second delay before participation.  
I have tried with both STP on and off, and there is no difference.  What am 
I doing wrong?

Also, how can I get the current setting of forwarding delay and other 
bridge parameters that the brctl utility allows me to set?  Why doesn't the 
brctl utility have a 'get' corollary for each 'set' command?  For example, 
I would like to see a 'getfd' command added to the brctl utility.  

Thanks,
-Chris

-- 
| Christopher Cole, Cole Design and Development, LLC          cole@coledd.com |
| Embedded Software Development and Electronic Design       http://coledd.com |
| Stow, Ohio, USA                                              1-800-518-2154 |
