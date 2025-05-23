PS C:\Users\nf26742\Desktop> import re
>>
>> # File name of the tree
>> input_file = "Mbovis-All_2025-02-25_21-50-10.tre"
>> output_file = "tip_names.txt"
>>
>> # Read the Newick tree text
>> with open(input_file, "r") as file:
>>     tree_text = file.read()
>>
>> # Regex to extract tip names (anything after a comma or parenthesis and before a colon)
>> tip_names = re.findall(r'[\(,]([^\(\),:]+):', tree_text)
>>
>> # Remove duplicates and sort
>> unique_tips = sorted(set(tip_names))
>>
>> # Write to output file
>> with open(output_file, "w") as out:
>>     for tip in unique_tips:
>>         out.write(f"{tip}\n")
>>
>> print(f"Extracted {len(unique_tips)} unique tip names to {output_file}")
>>
At line:8 char:21
+ with open(input_file, "r") as file:
+                     ~
Missing argument in parameter list.
At line:9 char:27
+     tree_text = file.read()
+                           ~
An expression was expected after '('.
At line:12 char:45
+ tip_names = re.findall(r'[\(,]([^\(\),:]+):', tree_text)
+                                             ~
Missing argument in parameter list.
At line:18 char:22
+ with open(output_file, "w") as out:
+                      ~
Missing argument in parameter list.
At line:19 char:8
+     for tip in unique_tips:
+        ~
Missing opening '(' after keyword 'for'.
    + CategoryInfo          : ParserError: (:) [], ParentContainsErrorRecordException
    + FullyQualifiedErrorId : MissingArgument
