Date: Thu, 1 Apr 2004 14:49:33 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040401144933.3183bf2c@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [announce] bridge-utils-0.9.7
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: linux-net@vger.kernel.org, bridge@osdl.org

Updated the bridge-utils software to handle:
	* Greater than 32 bridges; now unlimited as far as the command 
	  is concerned.
	* Follow version convention: brctl -V 
	* More complete and robust error handling, checks for errors
	  when initializing and reading bridge information

Known pre-existing issues:
	* Mixed 64bit/32bit ioctl handling was incorrect and removed.
	  Will be replaced by correct code later.  I.e for now still
	  broken.
	* Still has limit of 256 ports per bridge until STP is updated.
	* Command reads in all the bridge information (even if it doesn't
	  need it).

Available at:
	http://prdownloads.sourceforge.net/bridge/bridge-utils-0.9.7.tgz?download

There is no reason to update existing 2.4 systems, this is really intended
for 2.6 based distros.
