content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Date: Wed, 14 Jul 2004 12:38:18 -0500
Message-ID: <30F5491FC3F68047925F0F51C190BCD701571028@ACDFWMAIL1.acd.de.ittind.com>
From: "Saxer, John -ACDSD" <John.Saxer@itt.com>
Content-Transfer-Encoding: 8bit
Subject: [Bridge] Making a bridge work without source address spoofing
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org


So, I agree, the curent wireless card I have been given does not allow source address spoofing, but I still would like to use bridging. I wonder if anyone has tried modifying the bridge code to encapsulate the actual packet in some way so that the desired source address can be preserved?

I am thinking of something like duplicating the ETH header, adding it to the beginning of the packet, so that there are 2 headers. I know that the wireless card strips the header off, adding its own header, and so it would strip off the extra one, leaving the original unchanged. Then, when the packet arrives, I would add software to strip the wireless header off again, leaving me with the original packet again!

I guess I am thinking that I could add this "extra" header processing in the wireless driver. Do you think this might work?

John Saxer
ITT A/CD San Diego

************************************
This email and any files transmitted with it are proprietary and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email
in error please notify the sender. Please note that any views or opinions presented in this email are solely those of the author and do not necessarily represent those of ITT Industries, Inc.
The recipient should check this email and any attachments for the presence of viruses. ITT Industries accepts no liability for any damage caused by any virus transmitted by this
email.
************************************

