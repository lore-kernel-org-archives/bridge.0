Message-ID: <4C9D6D17.1060303@sauce.co.nz>
Date: Sat, 25 Sep 2010 15:31:35 +1200
From: Richard Scobie <richard@sauce.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Very poor RX performance on 2.6.35.4
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

I have a box containing 2 x 10Gb and 4 x 1Gb adapters, set up as a 
bridge, containing a large amount of storage, which has been performing 
very well on kernel 2.6.27.19-78.2.30.fc9.x86_64.

I have updated to 2.6.35.4 and while clients attached to it are able to 
receive at full speed, files sent either to the storage on the bridge or 
other attached clients now only reach 500kB/s.

I have no reason to suspect the bridge code, but thought I'd try here 
first, as I can see no signs of trouble in logs or interface stats.

It's not likely to be a network driver issue, as there are three 
different adapters and two drivers, (e1000e and ixgbe) and this problem 
occurs through all three.

Booting back to 2.6.27 brings performance back to normal.

Regards,

Richard
